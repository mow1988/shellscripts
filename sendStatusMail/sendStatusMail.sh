#! /bin/bash
print_header() {
echo " "
echo "========================"
echo "${1}:"
echo "========================"
}

mailSub="[$(cat /etc/hostname)] Status"
mailTo=$1
tmp=/tmp/sendStatusMail.tmp

#pre commands
rm -f $tmp
apt-get update >/dev/null

echo "Uptime: $(uptime)" 		                                 >> $tmp
echo "Package updates: $(apt-get --just-print upgrade|grep 'upgraded') " >> $tmp

print_header "Docker container" >> $tmp
docker container ls >> $tmp

print_header "Running services" >> $tmp
service --status-all | grep "+" | awk '{print $4}' >> $tmp

if [ -z $mailTo ]
then
 cat $tmp
else
 cat $tmp | mail -s $mailSub $mailTo
fi
