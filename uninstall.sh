#!/bin/bash
#
# Unistall xmltv script
#
# v.1.1

# Removing script
rm /usr/script/xmltv.sh

# Removing epg data
rm /etc/epgimport/new.EPG.sources.xml
rm -r /media/hdd/epg

# Removing Cron
crontab -l | grep -v "\00 \06 \* \* \* cd /usr/script/ && ./xmltv.sh" | crontab -

exit
