#! /bin/bash
mailSub="[$(cat /etc/hostname)] Status"
mailTo=$1
tmp=/tmp/sendStatusMail.tmp

#pre commands
rm -f $tmp
apt-get update >/dev/null

echo "========================"      >> $tmp
echo "Uptime:" 		             >> $tmp
echo "========================"      >> $tmp
uptime >> $tmp

echo "" >> $tmp
echo "========================"      >> $tmp
echo "Package updates:"              >> $tmp
echo "========================"      >> $tmp
apt-get --just-print upgrade | grep 'upgraded'  >> $tmp


echo "" >> $tmp
echo "========================"      >> $tmp
echo "Docker container status:"      >> $tmp
echo "========================"      >> $tmp
docker container ls >> $tmp

cat $tmp | mail -s $mailSub $mailTo
