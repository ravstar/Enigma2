To fix offset EPG of your IPTV provider i.e. if your epg is ahead or behind and showing wrong program information. You can adjust the offset time between any range from 1 minute to upto 23 hours.

HOW DOES IT WORK: The below script will create a new source file for EPGimporter and fix the offset time issue of your provider's epg by downloading it onto your HDD and fixing it so you get the correct programme guide. This will also setup a daily cron that will update the data everyday at 6:00am

PLEASE NOTE: This will ONLY work if you have created bouquets and playlist with JediMakerxtreme

HOW TO EXECUTE: You only need to run the below script ONCE. Follow my setup by step guide.

You will need SSH client: to connect to your Enigma2 box to run the above script, I personally use Putty available from http://www.putty.org/
OpenATV users can use the terminal within OpenWebif

wget -O /tmp/setup.sh "https://github.com/ravstar/Enigma2/raw/main/setup.sh" && sed -i 's,llllll,http://DOMAIN-URL:PORT,g;s,uuuuuu,USERNAME,g;s,pppppp,PASSWORD,g;s/temp/-HHMM/g' /tmp/setup.sh && cd /tmp/ && chmod 755 setup.sh && ./setup.sh

Step 1: Please replace following in the above link else it won't work

DOMAIN-URL :- to be replaced with your iptv provider domain/server url address this would be like http://iptvline.com

PORT :- to be replaced with your iptv provider port that would be 80 or 8080 or 2543 etc.

USERNAME :- to be replaced with your iptv username

PASSWORD :- to be replaced with your iptv password

HHMM :- this would be the time that you would like to adjust the EPG for. You can adjust this range from 1 minute upto 23 hrs.
    
    Example- if your epg is half an hour ahead then  put -0030
             if your epg is an hour ahead then  put -0100
             if your epg is two hour ahead then put -0200
             if your epg is half an hour behind then  put +0030
             if your epg is an hour behind then put +0100
             if you epg is two hour behind then put +0200, and so on..

Step 2: Connect to your enigma2 box using SSH and login to your box

Step 3: Paste the above link after making changes as described above and hit enter.

Point to be noted: The time taken by script from start to finish would depend on EPG data and processing power of your box. For example: my provider's epg.xml file is 40Mb in size so my Zgemma H9S takes around 9 mins to update the file everyday on other side Zgemma H2S takes 50-60 mins to update the file. But it will run in the background and won't intrupt if you are watching any programme.

Once done, go into epg importer, press blue button(sources) on your box remote and look for a option named 'New-EPG_your Jedimaker playlist name'
press the '+' sign and then check the source inside it.
Very important: Make sure you un-check the epg source created by Jedimakerextreme earlier in this list.
Press green button(Save)
Look for option named 'Clearing current EPG before import' and turn it to yes.
Import EPG manually by pressing yellow button.
EPGimporter will start importing EPG data.

As I mentioned above the default time for daily cron is 6:00am so make sure you set your epg importer 'automatic start time' not before 7:10am

All done! Happy viewing.

If you would like to uninstall all above then paste following link in your SSH client and hit enter.

wget -O /tmp/uninstall.sh "https://github.com/ravstar/Enigma2/raw/main/uninstall.sh" && cd /tmp/ && chmod 755 uninstall.sh && ./uninstall.sh
