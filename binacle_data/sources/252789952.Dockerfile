FROM centos:7  
MAINTAINER "Cameron Brunner" brunner@univa.com  
RUN yum -y install ntp; yum -y clean all  
LABEL RUN="docker run -d --cap-add='SYS_TIME' IMAGE"  
CMD [ "/usr/sbin/ntpd", "-n", "-b", "-g" ]  

