FROM ubuntu:trusty  
MAINTAINER Brian J. Cardiff <bcardiff@gmail.com>  
  
RUN mkdir /backup  
  
ENV CRON_TIME="0 0 * * *"  
ADD run.sh /run.sh  
VOLUME ["/backup","/target"]  
  
CMD ["/run.sh"]  

