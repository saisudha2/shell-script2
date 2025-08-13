#!/bin/bash

USERID=$(id -u)
SOURCE_DIR=$1
DEST-DIR=$2
DAYS=${3: -14}




LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/backup.logs"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"



VALIDATE(){
    if [ $1 -eq 0 ]
    then
      echo -e "$2 is ...$G SUCCESS $N" |  tee -a  $LOG_FILE
    else
      echo -e "$2 is ... $R FAILED $N" |  tee -a  $LOG_FILE
      exit 1
    fi
}

check_root(){
    if [ $USERID -ne 0 ]
    then
      echo -e "$R ERROR:: please run this script with root access $N" | tee -a  $LOG_FILE
      exit 1
    else 
      echo -e "$Y you are running with root access" | tee -a  $LOG_FILE
    fi
}

check_root
mkdir -p $LOGS_FOLDER

USAGE(){
     echo -e "$R USAGE:: $N sh 15-backup.sh <source-dir> <destination-dir> <days(optional)>"
     exit 1
}

if [ $# -lt 2]
then
  USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
  echo -e "$R Source Directory $SOURCE_DIR does not exist. Please check $N"
  exit 1
fi

if [ ! -d $DEST_DIR ]
then
  echo -e "$R Destination Directory $Dest_DIR does not exist. Please check $N"
  exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ ! -z "$FILES"]
then
  echo "Files to zip are: $FILES"
  TIMESTAMP=$(date +%F-%H-%M-%S)
  ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
  find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
  
  if [ -f $ZIP_FILE ]
  then
      echo -e "Successfully created Zip file"
       

      while IFS= read -r filepath
      do
          echo "Deleting file: $filepath" |  tee -a  $LOG_FILE
          rm -rf $filepath
      done <<< $FILES 
      echo -e "Log files older than $DAYS from source directory removed ... $G SUCCESS $N"
   else
      echo -e "Zip file creation ...$R FAILURE $N"
      exit 1
    fi
else
   echo -e "No log files found older than 14 days .... $Y SKIPPING $N"
fi   

            







