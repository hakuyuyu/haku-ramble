#!/bin/bash

if [ ! $1 ]; then

   echo 'ERROR: Need to apply loop param'    

   exit  

fi



# Start from target date (2025-01-02) and go forwards to fill gaps in 2025

current_date="2025-01-02"


for i in $(seq 1 $1)

do

   # Randomize commit time between 9 AM and 6 PM to avoid GitHub filtering
   # Generate random hour (9-17) and random minute (0-59)
   random_hour=$((9 + RANDOM % 9))
   random_minute=$((RANDOM % 60))
   random_second=$((RANDOM % 60))
   
   # Format time as HH:MM:SS
   commit_time=$(printf "%02d:%02d:%02d" $random_hour $random_minute $random_second)

   export GIT_AUTHOR_DATE="$current_date $commit_time -0800"

   export GIT_COMMITTER_DATE="$current_date $commit_time -0800"

   sh ./push.sh

   # Add 1 day (macOS date syntax) - going forwards from 2025-01-02

   current_date=$(date -j -v+1d -f "%Y-%m-%d" "$current_date" "+%Y-%m-%d")
   
   # Small delay to avoid rate limiting and make it look more natural
   sleep 1

done


