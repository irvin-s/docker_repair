FROM ibmimages/mqadvanced:latest  
  
MAINTAINER Luciano Jesus Lima <developer@brazilianbytes.com>  
  
COPY *.sh /usr/local/bin/  
COPY *.mqsc /etc/mqm/  
  
ENTRYPOINT ["mq-remote.sh"]  

