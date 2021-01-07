wget -O /media/hdd/epg/iptvepg.xml "http://link/xmltv.php?username=nnnnnn&password=wwwwww&next_days=7"
sed -i 's/+0000/time/g' /media/hdd/epg/iptvepg.xml
gzip -f /media/hdd/epg/iptvepg.xml > /media/hdd/epg/iptvepg.xml.gz
exit
