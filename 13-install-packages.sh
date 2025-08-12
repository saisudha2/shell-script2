#!/bin/bash

ID=$(id -u)

TIMESTAMP=$(date +%F-%H-%M-%S)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "Script started executing at $TIMESTAMP" &>> $LOGFILE


VALIDATE(){
    if [ $1 -ne 0 ]
    then
      echo -e " ERROR:: $2.. is $R Failed $N"
      exit 1
    else
      echo -e "$2 is .... $G SUCCESS $N"
    fi  
}

if [ $ID -ne 0 ]
then
  echo -e "$R ERROR:: please run this script with root access $N"
  exit 1
else
   echo  -e " $G you are root user $N"
fi

# echo "All arguments passed: $@"
# git mysql postfix net-tools
# package=git for first time

for package in $@
do
  yum list installed $package  &>> $LOGFILE
  if [ $? -ne 0 ]
  then
    yum install $package -y  &>> $LOGFILE
    VALIDATE $? "Installing of $package"
  else
    echo -e "$package is already installed.....$Y skipping $N"
  fi
done      
 
