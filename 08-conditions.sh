#!/bin/bash

NUMBER=$1

if [ $NUMBER -gt: 100 ]
then
   echo "given number $NUMBER is greater than 100"
else
    echo "given number $NUMBER is  not greater than 100"
fi