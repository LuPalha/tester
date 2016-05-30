#!/bin/bash

nc -w 2 --recv-only --send-only $1 $2
var=$?

if [ "$var" -eq "0" ];
then
   echo 1
   exit
else
   echo 0
   exit
fi


