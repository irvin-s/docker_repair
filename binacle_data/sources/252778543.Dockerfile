FROM ubuntu:trusty  
  
RUN apt-get update && apt-get dist-upgrade -y  
RUN apt-get install -y zookeeper  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN sed -i 's/ROLLINGFILE/CONSOLE/' /etc/zookeeper/conf/environment  
  
ADD start.sh /usr/local/bin/start.sh  
  
CMD ["/usr/local/bin/start.sh"]

