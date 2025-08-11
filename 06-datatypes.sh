#!/bin/bash

NUMBER1=$1
NUMBER2=$2

SUM=$(($NUMBER1+$NUMBER2))

echo "total:: $SUM"

echo "how many args passed:: $#"

echo "All args passed:: $@"

echo "script name:: $0"