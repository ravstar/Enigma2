#!/bin/sh
#

echo "Downloading EPG data..."

wget -O dddddd "hhhhhh"

clock=$(date '+%H:%M:%S:')
echo $clock "CORRECTING TIME. PLEASE WAIT, IT WOULD TAKE BETWEEN 10-50 MINUTES SO BE PATIENT..."


sed -i '/+0000/ s//tttttt/g' dddddd
gzip -f dddddd > dddddd.gz

sed -i "s|hhhhhh|dddddd.gz|g" ssssss

clock1=$(date '+%H:%M:%S:')
echo $clock1 "All done! go to epgimpoter, Look for option named 'Clearing current EPG before import' and turn it to yes and Import EPG manually by pressing yellow button"


exit
