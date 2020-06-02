FROM binsix/centos7  
MAINTAINER LiuBin  
LABEL name="sshcentos7" license="MIT" build-date="20170812"  
  
ENV VERSION 6.6.1p1-35.el7_3  
  
RUN yum update -y && yum install -y openssh-server openssh-clients  
  
EXPOSE 22  
CMD /usr/sbin/sshd & tail -f /dev/null

