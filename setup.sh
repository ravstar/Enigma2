mkdir -p /media/hdd/epg
wget -O /usr/script/xmltv.sh "https://github.com/ravstar/Enigma2/raw/main/xmltv.sh"
sed -i 's+url+/media/hdd/epg/iptvepg.xml.gz+g' /etc/epgimport/der
sed -i 's+link+url+g' /usr/script/xmltv.sh
sed -i 's/time/tt/g' /usr/script/xmltv.sh
crontab -l | { cat; echo "00 06 * * * cd /usr/script/ && ./xmltv.sh "; } | crontab -
cd /usr/script/xmltv.sh
dos2unix xmltv.sh
chmod 755 xmltv.sh
./xmltv.sh
exit 
