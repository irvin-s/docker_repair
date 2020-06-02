##########################################################  
# Dockerfile to build container image of Nagios  
# Based on Ubuntu  
############################################################  
  
# Set the base image to Ubuntu  
FROM ubuntu  
  
# File Author / Maintainer  
MAINTAINER RajithaK (rajithak@brandix.com)  
  
WORKDIR /tmp  
  
# Update the repository sources list  
RUN apt-get update  
  
# Install Nagios Master Server  
RUN apt-get install -y nagios3 nagios-nrpe-plugin &&\  
apt-get install -y elinks &&\  
apt-get install -y nano &&\  
apt-get install -y openssh-server &&\  
htpasswd -c /etc/nagios3/htpasswd.users nagiosadmin  
  
EXPOSE 8080 80 22  
  
RUN mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.backup &&\  
mv /etc/bash.bashrc /etc/bash.bashrc.backup  
  
ADD apache2.conf /etc/apache2/  
ADD bash.bashrc /etc/  

