This is how to fix offset EPG of your IPTV provider i.e. if your epg is ahead or behind and showing wrong program information.

Below link will download a script and setup daily cron in your enigma2 box which will download your provider epg everyday at 6:00am and fix the time offset issue.

wget -O /tmp/setup.sh "https://github.com/ravstar/Enigma2/raw/main/setup.sh" && sed -i 's,url:port,PROVIDER-LINK:PORT,g;s,uuuuuu,USERNAME,g;s,pppppp,PASSWORD,g;s/temp/HHMM/g;s/der/FILENAME.xml/g' /tmp/setup.sh && cd /tmp/ && chmod 755 setup.sh && ./setup.sh

Please replace following in the above link else it won't work

PROVIDER-LINK :- to be replaced with your iptv provider domain/server url this would be like iptvline.com

PORT :- to be replaced with your iptv provider port that would be 80 or 8080 or 2543 etc.

USERNAME :- to be replaced with your iptv username

PASSWORD :- to be replaced with your iptv password

HHMM :- this would be the time that you would like to adjust the EPG for. You can adjust this range from 1 minute upto 24 hrs.
    
    Example- if your epg is half an hour ahead then  put -0030
             if your epg is an hour ahead then  put -0100
             if your epg is two hour ahead then put -0200
             if your epg is half an hour behind then  put +0030
             if your epg is an hour behind then put +0100
             if you epg is two hour behind then put +0200, and so on..

FILENAME.xml :- You have to look for a source file in /etc/epgmiport/ directory. For example: If you have created bouquets with Jedimaker then the file name would be jmx.XXXX.sources.xml here XXXX would be the name you have assigned to your playlist/bouquet name in jedimaker extreme. If you have created bouquets with echannelizer then the file name would be echannelizer.sources.xml.

How to execute: YOU ONLY NEED TO RUN THIS ONCE

You will need SSH client: to connect to the device to run the above script, I personally use Putty available from http://www.putty.org/

Point to be noted: The time taken by script from start to finish would depend on your box for example my Zgemma H9S takes around 9 mins to update the file everyday on other side Zgemma H2S takes 50-60 mins to update the file. But it will run in the background and won't intrupt if you are watching anything on your box.

Once done, go into your epg importer, clear current EPG before importing and import manually by pressing yellow button on your zgemma box.

As I mentioned above the default time for daily cron is 6:00am so make sure you set your epg importer automatic start time not before 7:10am

You can change the cron timer by using putty.
