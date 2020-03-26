# Redhat Cockpit docker Image  
# version 0.0.1  
From ubuntu:15.04  
Maintainer "Ayoub Boulila" <ayoubboulila@gmail.com>  
  
RUN apt-get -y install software-properties-common systemd-sysv  
RUN add-apt-repository ppa:jpsutton/cockpit \  
&& apt-get -y update  
RUN apt-get -y install cockpit  
  
RUN systemctl enable cockpit \  
&& systemctl start cockpit.service  
  
EXPOSE 9090  
  
  

