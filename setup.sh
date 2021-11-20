#!/bin/sh
#
# v1.2

echo "uninstalling previous version of this script"

# Remove old script data
rm /etc/epgimport/new.EPG.sources.xml
rm /etc/hdd/epg/iptvepg.xml.gz
# Removing Cron
cron=$(crontab -l | grep -F "00 06 * * * cd /usr/script/ && ./xmltv.sh " | wc -m)
if [ $cron -eq "0" ]; then
echo "no cron found"
else
crontab -l | grep -v "00 06 \* \* \* cd /usr/script/ && ./xmltv.sh " | crontab -
echo
echo "Old cron removed"
fi
cron=$(crontab -l | grep -F "59 05 * * * cd /usr/script/ && ./xmltv.sh " | wc -m)
if [ $cron -eq "0" ]; then
echo "no cron found"
else
crontab -l | grep -v "59 05 \* \* \* cd /usr/script/ && ./xmltv.sh " | crontab -
echo
echo "Old cron removed"
fi
cron=$(crontab -l | grep -F "10 06 * * * cd /usr/script/ && ./xmltv.sh " | wc -m)
if [ $cron -eq "0" ]; then
echo "no cron found"
else
crontab -l | grep -v "10 06 \* \* \* cd /usr/script/ && ./xmltv.sh " | crontab -
echo
echo "Old cron removed"
fi

xmltv=$(cd /usr/script/ && ls -d *xmltv.sh* | wc -l)
if [ $xmltv -eq "1" ]; then
graburl=$(grep -o 'url=".*$' /usr/script/xmltv.sh | cut -c6- | cut -f 1 -d '"')
echo $graburl
grabxmltvfilename=$(grep -o 'xmltvfilename=".*$' /usr/script/xmltv.sh | cut -c16- | cut -f 1 -d '"')
echo $grabxmltvfilename
grabsource=$(grep -o 'source=".*$' /usr/script/xmltv.sh | cut -c9- | cut -f 1 -d '"')
echo $grabsource
pathh=$(grep -o '\[CDATA\[.*$' $grabsource | cut -c8- | cut -f 1 -d "]")
if [ "$pathh" == "$grabxmltvfilename".gz ]; then
sed -i "s|$grabxmltvfilename.gz|\\&|" $grabsource
sed -i "s|\\&|$graburl|" $grabsource
rm ${grabxmltvfilename}.gz
echo "Original iptv url replaced in $grabsource"
else
echo "Iptv url already exists in $grabsource"
fi
fi
echo "starting new installation"

workdir="/media/hdd/epg"
epgimport="/etc/epgimport"
echo
echo "This script will fix EPG offset issue for IPTV i.e. if your epg is ahead or behind and showing wrong program information. 
You can adjust the offset time between any range from 1 minute to up to 23 hours."
echo
sleep 6

count=$(cd ${epgimport}/ && ls -d *jmx.*.sources.xml* | wc -l)
if [ $count -eq "1" ]; then
   filename=$(find ${epgimport}/ -name "jmx.*.sources.xml" -exec basename {} \;)
   echo "One jedimaker playlist found: $filename, proceeding installation..."
   sleep 2
else
echo "Enter full file name from below list starting with jmx.XXXX.sources.xml, For example: You want to fix EPG offset for provider's playlist named IPTV in jedimakerxtreme then you should look for file named jmx.IPTV.sources.xml"
echo
find $epgimport/ -name "jmx.*.sources.xml" -exec basename {} \;
echo
read -p "Enter file name: " filename
fi
filename1=$(cd ${epgimport}/ && ls ${filename})
if [ "$filename1" == "$filename" ]; then 
echo
else
echo "Wrong input installation aborted. Try to run the script again by typing ./setup.sh below and hit enter"
echo
exit
fi
echo
echo "Enter the time you would like to offset including +/-HHMM
Example:
        your epg is half an hour ahead then put -0030
        your epg is an hour ahead then put -0100 
	your epg is two hours ahead then put -0200 
	your epg is half an hour behind then put +0030 
	your epg is an hour behind then put +0100 
	your epg is two hours behind then put +0200, and so on.."
echo
read -p "Enter time: " time
echo
echo $filename
echo
echo $time
if [ ! -d "${workdir}" ]; then
  mkdir -p "${workdir}" 
fi
source="${epgimport}/$filename"
# get url from source file
url=$(grep -o "<url><\!\[\CDATA.*$" ${source} | cut -c 15- | cut -f 1 -d ']')
echo $url
#get name from source file, remove illegal file characters with underscore and make lower case
name=$(grep -o 'catname=.*$' ${source} | cut -c10- | cut -f 1 -d '"' | \
sed -e 's|<|_|g; s|>|_|g; s|:|_|g; s|"|_|g; s|/|_|g; s|\\|_|g; s/|/_/g; s|?|_|g; s|*|_|g; s| |_|g')
echo $name

insdir="/usr/script"
if [ ! -d "${insdir}" ]; then
  mkdir -p "${insdir}" 
fi

#download xmltv file (xmltv.sh) to filename $xmltvfilename - replace old time with new time
xmltvfilename="${workdir}/${name}.xml"
echo $xmltvfilename
wget -O /usr/script/xmltv.sh "https://github.com/ravstar/Enigma2/raw/main/xmltv.sh"
sed -i "s|\\&|$url|" "/usr/script/xmltv.sh"
sed -i "s|dddddd|$xmltvfilename|; s|tttttt|$time|; s|ssssss|$source|" "/usr/script/xmltv.sh"
cd /usr/script/ && chmod 755 xmltv.sh
wget -O /usr/script/uninstall1.sh "https://github.com/ravstar/Enigma2/raw/main/uninstall1.sh"
sed -i "s|dddddd|$xmltvfilename|; s|tttttt|$time|; s|ssssss|$source|" "/usr/script/uninstall1.sh"
cd /usr/script/ && chmod 755 uninstall1.sh

crontab -l | { cat; echo "10 06 * * * cd /usr/script/ && ./xmltv.sh "; } | crontab -
echo "Daily cron added to run script daily at 06:10am"

HHMM=$(wget -qO- "$url" | awk -F 'start="' '{print $2;exit;}' | cut -c15- | cut -f 1 -d '"' | tail -n +1 | head -1)
echo
echo "xml HHMM is $HHMM"
echo
if [ $HHMM -eq "+0000" ]; then
   cd /usr/script/ &&./xmltv.sh
else
echo "ERROR: Script has been installed though it won't work until you follow one more step manually. Please make a note of following text"
echo
echo "My xml HHMM is: $HHMM and I want to adjust it by: $time"
echo
echo "Please follow the additional step mentioned in original post or reach out to 'ravstar'"
echo
fi
rm /tmp/setup.sh
exit
