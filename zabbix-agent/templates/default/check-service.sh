#!/bin/bash
var=$(ps -ef | grep $1 | grep -v grep | grep -v "check-service" | awk {'print $2'} | wc -l)
if [ $var -gt 0 ]
then
       echo 1
else
       echo 0
fi
