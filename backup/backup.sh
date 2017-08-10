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

$cmd > $logFile
