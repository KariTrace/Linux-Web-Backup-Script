# !/bin/bash

# Home Directory
HOMEDIR=/backup
# FTP Username
USERNAME=
# FTP Password
FTPPASSWORD=
# FTP Hostanme or IP Address
HOSTNAME=
# Server Name
SERVERNAME=
# Send Confirmation email to this address
EMAILADDRESS1=



# Date format for file
DATE=`date +%A_%b_%d_%Y`

# Uptime
UPTIME=`uptime`

#Make Directory
mkdir /backup/$DATE >> /backup/$DATE.log

# mySQL
DBUSER=sugarcrm
DBPSWD=P1n3ll4sSug4r
DATABASE1=sugarcrm

# Touch Log file
echo "-+-+-+-+-" >> $HOMEDIR/$DATE.log
echo $DATE >> $HOMEDIR/$DATE.log
echo "-+-+-+-+-" >> $HOMEDIR/$DATE.log
echo $UPTIME >> $HOMEDIR/$DATE.log

# Backup Database
cd $HOMEDIR/$DATE/
mysqldump --user=$DBUSER --password=$DBPSWD --databases $DATABASE1 > $HOMEDIR/$DATE/$DATABASE1.sql
cd

# rsync Meta partition to $BACKDIR/$DATE/
rsync -a -v /var/www/html/ /backup/$DATE/html/ >> /backup/$DATE.log

# TAR UP FILES
tar -czf $HOMEDIR/$SERVERNAME$DATE.tar.gz /backup/$DATE >> /backup/$DATE.log

# Send backup files to redundant back up server
curl -T $HOMEDIR/$SERVERNAME$DATE.tar.gz ftp://$USERNAME:$FTPPASSWORD@$HOSTNAME/ >> $HOMEDIR/$DATE.log

# remove rsync copies
#rm -Rf /backup/$DATE
#rm -rf /backup/$SERVERNAME$DATE.tar.gz

#Mail user when complete

