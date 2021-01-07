wget -O /media/hdd/epg/iptvepg.xml "link"
sed -i 's/+0000/time/g' /media/hdd/epg/iptvepg.xml
gzip -f /media/hdd/epg/iptvepg.xml > /media/hdd/epg/iptvepg.xml.gz
exit
