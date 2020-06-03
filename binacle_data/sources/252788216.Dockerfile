#FROM ubuntu:16.04  
FROM ubuntu:xenial  
  
MAINTAINER Christian Riedl <riedlc@gmail.com>  
  
RUN apt-get update && apt-get -y install openssl supervisor cron git  
RUN cd /opt; git clone https://github.com/diafygi/acme-tiny.git  
  
ADD usr/local/sbin /usr/local/sbin  
  
CMD run.sh  

