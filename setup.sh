cd
mkdir -p /media/hdd/epg
cd /etc/epgimport/
find . -type f -name "jmx.*.sources.xml" -exec cp {} /media/hdd/epg \;
cd /media/hdd/epg/ && mv *.sources.xml new.EPG.sources.xml
mv /media/hdd/epg/new.EPG.sources.xml /etc/epgimport
sed -i 's,llllll/xmltv.php?username=uuuuuu&password=pppppp&next_days=7,/media/hdd/epg/iptvepg.xml.gz,g' /etc/epgimport/new.EPG.sources.xml
sed -i 's/sourcecatname="/sourcecatname="New-EPG_/g' /etc/epgimport/new.EPG.sources.xml
sed -i 's/<description>/<description>New-EPG_/g' /etc/epgimport/new.EPG.sources.xml
wget -O /usr/script/xmltv.sh "https://github.com/ravstar/Enigma2/raw/main/xmltv.sh"
sed -i 's,link,llllll,g;s,nnnnnn,uuuuuu,g;s,wwwwww,pppppp,g' /usr/script/xmltv.sh
sed -i 's/time/temp/g' /usr/script/xmltv.sh
cd
crontab -l | { cat; echo "00 06 * * * cd /usr/script/ && ./xmltv.sh "; } | crontab -
cd /usr/script/
chmod 755 xmltv.sh
./xmltv.sh
rm /tmp/setup.sh
