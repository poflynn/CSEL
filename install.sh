#!/bin/bash

#Merge the config with the code, output it to csel file
echo 'Merging csel.cfg with payload...'
cat csel.cfg payload > /usr/local/bin/csel_SCORING_ENGINE_DO_NOT_TOUCH
sed -i "s/%KERNEL%/"`uname -r`"/g" /usr/local/bin/csel_SCORING_ENGINE_DO_NOT_TOUCH
sed -i "s/%INSTALLDATE%/"`date +%s`"/g" /usr/local/bin/csel_SCORING_ENGINE_DO_NOT_TOUCH
echo -e 'DONE\nInstalling csel into /usr/local/bin...'
chmod 777 /usr/local/bin/csel_SCORING_ENGINE_DO_NOT_TOUCH #Make it executable

#Check for crontab entry, add it if it doesn't exist
echo -e 'DONE\nAdding crontab entry...'
touch /var/log/csel.log
chmod 777 /var/log/csel.log
if [[ $(crontab -l -u root | grep csel) ]] ; then :; else
  (crontab -l -u root ; echo "*/1 * * * * /usr/local/bin/csel_SCORING_ENGINE_DO_NOT_TOUCH 2&1>/var/log/csel.log")| crontab -
fi

#Check for CYBER folder, create if it doesn't exist
echo -e 'DONE\nCreating /home/CYBERPATRIOT directory for icons...'
if [ ! -d "/home/CYBERPATRIOT_DO_NOT_REMOVE" ]
then
  mkdir /home/CYBERPATRIOT_DO_NOT_REMOVE
  cp logo.png /home/CYBERPATRIOT_DO_NOT_REMOVE/logo.png
  cp iguana.png /home/CYBERPATRIOT_DO_NOT_REMOVE/iguana.png
fi

#Fire csel to create the initial Score Report
echo -e 'DONE\nFiring csel for the first time...'
csel_SCORING_ENGINE_DO_NOT_TOUCH

#Finish up
scoreReportLoc=$( grep -Po '(?<=index=\().*?(?=\))' csel.cfg )
echo -e 'DONE\n----------------------------------\n\nScore Report is located at:' $scoreReportLoc
