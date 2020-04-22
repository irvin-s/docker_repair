#!/bin/bash

#Log_dir
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p ${HERE}/analyze_binacle_dataset/logs/history
mkdir -p ${HERE}/analyze_binacle_dataset/logs/success
mkdir -p ${HERE}/analyze_binacle_dataset/logs/fail


#File with  dockerfile names
images_file=$"images_list.txt"

 #Read the file with dockerfile names and try to execute
 while read line; do

	# parse hashcode
    	hash=$(echo $line | cut -c9-17)
    	logfile=${HERE}/analyze_binacle_dataset/logs/history/$hash.log

	## log file exists -> skip
    	if [ -f ${logfile} ];
    	then
        	echo "$hash already processed...skipping"
        	continue
    	fi

	# create dir and log history
    	mkdir -p $hash
   	(cd $hash;
     	cp -r ../analyze_binacle_dataset/sources/$hash.Dockerfile Dockerfile
     	touch $logfile
     	echo "Building image binacle:$hash"
     	## build image, dump output and error streams to $logfile
     	msg_log=$(docker build -t binacle:$hash . 2>&1 )

	## removes all images and test the built was successfully or failed
	if [[ $msg_log == *"Successfully tagged"* ]];
    	then
       		echo "$msg_log" > ${HERE}/analyze_binacle_dataset/logs/success/$hash.log 
       		docker system prune -af
    	else
       		echo "$msg_log" > ${HERE}/analyze_binacle_dataset/logs/fail/$hash.log
       		docker system prune -af
    	fi
	)
	rm -rf ${HERE}/$hash
	#sqlite3 db_docker_test.db "insert into tb_docker_tests_results (nm_image, error_msg) values ($line, $msg);"
 done<$images_file
