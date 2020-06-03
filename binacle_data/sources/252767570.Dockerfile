FROM debian:wheezy  
MAINTAINER mike@thefactory.com  
  
RUN apt-get update && apt-get install -y nagios-plugins nagios-nrpe-plugin  
ADD wrapper.sh /usr/local/bin/run-plugin  
  
ENTRYPOINT ["bash", "-e", "/usr/local/bin/run-plugin"]  

