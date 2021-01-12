#!/bin/bash
#
# Unistall xmltv script

xmltvfilename="dddddd"
url=$(grep -o 'url=".*$' /usr/script/xmltv.sh | cut -c6- | cut -f 1 -d '"')
echo $url
source="ssssss"

# Remove old script data
rm /etc/epgimport/new.EPG.sources.xml
rm /etc/hdd/epg/iptvepg.xml.gz

# Removing epg data
rm ${xmltvfilename}.gz

sed -i "s|$xmltvfilename.gz|&|" $source
sed -i "s|\\&|$url|" $source

# Removing Cron
crontab -l | grep -v "\00 \06 \* \* \* cd /usr/script/ && ./xmltv.sh" | crontab -

# Removing script
rm /usr/script/xmltv.sh

echo "script and crontab successfully uninstalled and source file restored"

rm /usr/script/uninstall.sh
exit
