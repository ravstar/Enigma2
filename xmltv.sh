wget -O /media/hdd/epg/iptvepg.xml "url"
sed -i 's/+0000/-0100/g' /media/hdd/epg/iptvepg.xml
gzip -f /media/hdd/epg/iptvepg.xml > /media/hdd/epg/iptvepg.xml.gz
exit
