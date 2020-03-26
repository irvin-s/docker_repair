#!/bin/bash

#Log_dir
LOG_DIR="/home/irvin_b/"
N=1

#Filename with images
images_file="images_list.txt"

 #Read the file with image names and try to execute
 while read line; do
	msg=$ &< docker run $line
        #${LOG_DIR}Exec_log${N}.log
	N=$((N+1))
	sqlite3 db_docker_test.db "insert into tb_docker_tests_results (nm_image, error_msg) values ($line, $msg);"
	docker system prune -f
 done<$images_file

