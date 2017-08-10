#! /bin/bash
mailSub="[$(cat /etc/hostname)] Status"
mailTo=$1
tmp=/tmp/sendStatusMail.tmp

#pre commands
rm -f $tmp
apt-get update >/dev/null

echo "Uptime: $(uptime)" 		                                 >> $tmp
echo "Package updates: $(apt-get --just-print upgrade|grep 'upgraded') " >> $tmp

echo ""
echo "========================"      >> $tmp
echo "Docker container status:"      >> $tmp
echo "========================"      >> $tmp
docker container ls >> $tmp

cat $tmp | mail -s $mailSub $mailTo
