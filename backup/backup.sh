#! /bin/bash
name=$1
srcDir=$2
dstDir=$3
dstFile=$1_$(date +%Y%m%d_%H%M%S).tar.gz
logDir=/var/log/backup/$1/
logFile=$dstDir/$dstFile.log

mkdir -p $logDir
mkdir -p $dstDir

cmd="tar -zcvf $dstDir/$dstFile $srcDir/*"
echo "=====================# START: backup.sh #========================" >> $logFile
echo "start: $(date)" >> $logFile
echo "src: $srcDir" >> $logFile
echo "dst: $dstDir/$dstFile" >> $logFile
echo "cmd: $cmd" >> $logFile
echo "=================================================================" >> $logFile

$cmd >> $logFile

echo "==============================================================" >> $logFile
echo "finished: $(date)" >> $logFile
ls -lha $dstDir/$dstFile >> $logFile
echo "====================# END: backup.sh #========================" >> $logFile
