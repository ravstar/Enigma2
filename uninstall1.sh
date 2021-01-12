#!/bin/bash
#
# Unistall xmltv script

xmltvfilename="dddddd"
url=$(grep -o 'url=".*$' /usr/script/xmltv.sh | cut -c6- | cut -f 1 -d '"')
echo $url
source="ssssss"

# Removing epg data
rm ${xmltvfilename}.gz

sed -i "s|$xmltvfilename.gz|\\&|" $source
sed -i "s|\\&|$url|" $source

# Removing Cron
crontab -l | grep -v "\59 \05 \* \* \* cd /usr/script/ && ./xmltv.sh" | crontab -

# Removing script
rm /usr/script/xmltv.sh

echo "script and crontab successfully uninstalled and source file restored"

rm /usr/script/uninstall1.sh
exit
