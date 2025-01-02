#!/bin/bash

if [ ! $1 ]; then

   echo 'ERROR: Need to apply loop param'    

   exit  

fi



# Start from target date (2025-01-02) and go forwards to fill gaps in 2025

current_date="2025-01-02"


for i in $(seq 1 $1)

do

   export GIT_AUTHOR_DATE="$current_date 13:00:00"

   export GIT_COMMITTER_DATE="$current_date 13:00:00"

   sh ./push.sh

   # Add 1 day (macOS date syntax) - going forwards from 2025-01-02

   current_date=$(date -j -v+1d -f "%Y-%m-%d" "$current_date" "+%Y-%m-%d")

done


