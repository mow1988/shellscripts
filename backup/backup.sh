#! /bin/bash

#FUNCIONS
log() {
echo $1 >> $2
}

cfgFile=$1

cat $cfgFile | \
while read JOB; do
 
 export JOB_NAME=$(echo $JOB | awk '{print $1}')
 export JOB_SRC=$(echo $JOB | awk '{print $2}')
 export JOB_DST=$(echo $JOB | awk '{print $3}')
 export JOB_CMP=$(echo $JOB | awk '{print $4}')
 export JOB_MAILTO=$(echo $JOB | awk '{print $5}')
 export JOB_LOG_DIR=/var/log/backup/$JOB_NAME
 export JOB_LOG_FILE=$JOB_NAME.$(date +%Y%m%d_%H%M%S).log 
 export logfile=$JOB_LOG_DIR/$JOB_LOG_FILE

 mkdir -p $JOB_LOG_DIR
 mkdir -p $JOB_DST
 
 log "============================" $logfile 
 log "job name: $JOB_NAME" $logfile
 log "job source: $JOB_SRC" $logfile
 log "job dest: $JOB_DST" $logfile
 log "job compress: $JOB_CMP" $logfile
 log "log file: $logfile" $logfile
 log "mailto: $JOB_MAILTO" $logfile
 log "============================" $logfile
 
 if [ $JOB_CMP == "YES" ]
 then
  export TAROPTS="cvfz"
  export TAREXT="tar.gz"
 else
  export TAROPTS="cfv"
  export TAREXT="tar"
 fi

 export DSTFNAME="$JOB_NAME.$(date +%Y%m%d_%H%M%S).$TAREXT"
 export BCKCMD="tar $TAROPTS $JOB_DST/$DSTFNAME $JOB_SRC"
 $BCKCMD >> $logfile
 echo "$JOB_NAME is FINISHED!!!" >> $logfile
 if [ ! -z $JOB_MAILTO ]
 then
  cat $logfile | mail -s "backup.sh on $(date +%Y%m%d_%H%M%S)" $JOB_MAILTO
 fi

done

