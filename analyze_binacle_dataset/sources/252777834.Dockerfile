FROM ubuntu:trusty  
  
RUN mkdir -p /profiler  
  
WORKDIR /tmp  
ADD install.sh install.sh  
RUN ./install.sh  
  
ADD xdebug.ini /etc/php5/cli/conf.d/20-xdebug.ini  
  

