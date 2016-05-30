#!/bin/bash
ntpstat | grep -w synchronised 1>/dev/null 2>/dev/null
if [ $? -eq 0 ]; then
       echo 1
else
       echo 0
fi


