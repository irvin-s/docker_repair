#!/bin/bash

# Variables
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BINACLE_DIR="${HERE}/binacle_data"

mkdir -p ${HERE}/logs/history
mkdir -p ${HERE}/logs/success
mkdir -p ${HERE}/logs/fail

# File with dockerfile names
images_file="images_list.txt"

# Verify the sources direcotry
if [ ! -d ${HERE}/binacle_data/sources ];
then
    echo "Please, download the dataset first!"
    exit
fi

# Read the file with dockerfile names and try to execute
while read line; do

	 # parse hashcode
    hash=$(echo $line | cut -f2 -d" " | cut -f2 -d"/" | cut -f1 -d\.)
    logfile=${HERE}/logs/history/$hash.log
    
	 ## log file exists -> skip
    if [ -f ${logfile} ];
    then
        echo "$hash already processed...skipping"
        continue
    fi
    
	 # create dir and log history
    mkdir -p $hash
    (cd $hash;
     cp -r ${BINACLE_DIR}/sources/$hash.Dockerfile Dockerfile
     touch $logfile
     echo "Building image binacle:$hash"

     ## build image, dump output and error streams to $logfile
     msg_log=$(docker build -t binacle:$hash . 2>&1 )

	  ## removes all images and test the built was successfully or failed
	  if [[ $msg_log == *"Successfully tagged"* ]];
     then
        if [[$msg_log ==*"returned a non-zero code"*]];
        then
            echo "../logs/fail/$hash.log" > ${HERE}/results/broken_files.log
        fi
       	echo "$msg_log" > ${HERE}/logs/success/$hash.log 
       	docker system prune -af
     else
       	echo "$msg_log" > ${HERE}/logs/fail/$hash.log
       	docker system prune -af
     fi
	 )
	 rm -rf ${HERE}/$hash
	 
done<$images_file