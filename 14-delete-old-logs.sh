#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.logs"
SOURCE_DIR=/home/ec2-user/app-logs

mkdir -p $LOGS_FOLDER

if [ $USERID -ne 0 ]
then
 echo -e "$R ERROR:: please run this script with root access $N" | tee -a  $LOG_FILE
 exit 1
else 
 echo -e "$Y you are running with root access" | tee -a  $LOG_FILE
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
      echo -e "$2 is ...$G SUCCESS $N" |  tee -a  $LOG_FILE
    else
      echo -e "$2 is ... $R FAILED $N" |  tee -a  $LOG_FILE
      exit 1
    fi
}

echo "script started executing at $(date)" |  tee -a  $LOG_FILE

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)

while IFS= read -r filepath
do
  echo "Deleting file: $filepath" |  tee -a  $LOG_FILE
  rm -rf $filepath
done <<< $FILES_TO_DELETE

echo "script executed successfully"





