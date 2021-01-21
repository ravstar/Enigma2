NEW INSTRUCTIONS & UPDATED SCRIPT 12/01/2021 v1.2

Please note: This version will automatically remove the previous version of this script.

How to fix offset EPG of your IPTV provider i.e. if your epg is ahead or behind and showing wrong program information. You can adjust the offset time between any range from 1 minute to up to 23 hours.

HOW DOES IT WORK: The below script will create a new source file for EPGimporter and fix the offset time issue of your provider's epg by downloading it onto your HDD and fixing it so you get the correct programme guide. This will also setup a daily cron that will update the data everyday at 6:00am

PLEASE NOTE: This will ONLY work if you have created bouquets and playlist with JediMakerxtreme

HOW TO EXECUTE: You only need to run the below script ONCE. Follow my setup by step guide.

Note: If 'Automatic live bouquet update' is enabled in your jedimakerextreme then make sure you set it's start time before 05:30am by going into jedimakerextreme > settings.

You will need SSH client: to connect to your Enigma2 box to run the below script, I personally use Putty available from http://www.putty.org/

OpenATV users can use the terminal within OpenWebif

Step 1: Connect to your enigma2 box using SSH and login to your box

Step 2: Paste the below link and hit enter.
wget -O /tmp/setup.sh "https://github.com/ravstar/Enigma2/raw/main/setup.sh" && cd /tmp/ && chmod 755 setup.sh && ./setup.sh

Step 3: Follow instructions on the terminal and it will set everything up for you.

Point to be noted: The time taken by script from start to finish would depend on EPG data and processing power of your box. For example: my provider's epg.xml file is 40Mb in size so my Zgemma H9S takes around 9 mins to update the file everyday on other side Zgemma H2S takes 50-60 mins to update the file. But it will run in the background and won't interrupt if you are watching any programme.

Once done,

Step 4: Go into epgimporter

Look for option named 'Clearing current EPG before import' and turn it to yes. (Note: you only need to clear EPG only once for the first run so do not press save after turning it to Yes).

Import EPG manually by pressing yellow button.

EPGimporter will start importing EPG data.

Make sure you set your epg importer 'automatic start time' not before 7:10am

All done! Happy viewing.

IF you get an ERROR saying Script has been installed though it won't work until you follow one more step manually

it will print additional text saying

""My xml HHMM is: +/-four digits and I want to adjust it by: +/-four digits""

Here's how you can fix it

Let's say the above text printed on your terminal as

My xml HHMM is: +0400 and I want to adjust it by: -0100

meaning your epg is an hour ahead so you need to change +0400 to +0300 (i.e. +0400-0100=+0300)

then you have to run below command as 

sed -i 's|+0000|+0400|g; s|-0100|+0300|g' /usr/script/xmltv.sh && ./xmltv.sh

this will complete the setup

Another example: text printed on your terminal as

My xml HHMM is: -0500 and I want to adjust it by: +0300

meaning your epg is 3 hours behind so you need to change -0500 to -0200 (i.e. -0500+0300=-0200)

then you have to run command as sed -i 's|+0000|-0500|g; s|+0300|-0200|g' /usr/script/xmltv.sh && ./xmltv.sh

One more example: text printed on your terminal as

My xml HHMM is: -0300 and I want to adjust it by: -0200

meaning your epg is 2 hours ahead so you need to change -0200 to -0500 (i.e. -0300-0200=-0500)

then you have to run command as sed -i 's|+0000|-0300|g; s|-0200|-0100|g' /usr/script/xmltv.sh && ./xmltv.sh

If you still need help, then post that message here in this thread and I will make the command for you to run to fix the error.

If you would like to uninstall above script and changes it has made for any reason, then paste following link in your SSH client and hit enter.
cd /usr/script && ./uninstall1.sh
