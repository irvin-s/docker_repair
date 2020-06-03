FROM tutum/ubuntu:trusty  
MAINTAINER Warren Legg  
  
# Add mysql scripts  
ADD ladrapp_dev.sql /var/lib/mysql/ladrapp_dev.sql

