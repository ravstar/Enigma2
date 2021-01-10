#!/bin/sh
#

xmltvfilename="dddddd"
url="hhhhhh"
time="tttttt"
source="ssssss"

echo "Downloading EPG data..."

wget -O ${xmltvfilename} "${url}"

clock=$(date '+%H:%M:%S:')
echo $clock "CORRECTING TIME. PLEASE WAIT, IT WOULD TAKE BETWEEN 10-50 MINUTES SO BE PATIENT..."

sed -i '/+0000/ s//${time}/g' ${xmltvfilename}

gzip -f  ${xmltvfilename} > ${xmltvfilename}.gz

#replace source - double quotes required for sed to convert variables. 
sed -i "s|$url|${xmltvfilename}.gz|g" $source



clock1=$(date '+%H:%M:%S:')
echo $clock1 "All done! go to epgimpoter, Look for option named 'Clearing current EPG before import' and turn it to yes and Import EPG manually by pressing yellow button"


exit
