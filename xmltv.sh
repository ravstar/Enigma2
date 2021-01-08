wget -O /media/hdd/epg/iptvepg.xml "link/xmltv.php?username=nnnnnn&password=wwwwww&next_days=7"
sed -i '/+0000/ s//time/g' /media/hdd/epg/iptvepg.xml
gzip -f /media/hdd/epg/iptvepg.xml > /media/hdd/epg/iptvepg.xml.gz
exit
