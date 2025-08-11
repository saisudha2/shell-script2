#!/bin/bash

ID=$(id -u)

if [ $ID -ne 0 ]
then
  echo "ERROR:: please run this script with root access"
  exit 1
else
  echo "you are root user"
fi

yum install mysql -y

if [ $? -ne 0 ]
then
  echo "ERROR:: installing Mysql is Failed"
  exit 1
else
  echo "Installing Mysql is success"
fi