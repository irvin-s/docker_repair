FROM ecc12/ssh-server:latest  
MAINTAINER Cameron King <cking@ecc12.com>  
  
RUN yum -y install sudo  
ADD singleuser /etc/sudoers.d/singleuser  
RUN chown root. /etc/sudoers.d/singleuser  
  

