FROM centos:6.8  
MAINTAINER buddyingdevelopment <development@buddying.jp>  
  
# Networking & Timezone  
RUN echo 'NETWORKING=yes' > /etc/sysconfig/network \  
&& echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock \  
&& ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime  
  
# Cron  
RUN yum install -y vixie-cron \  
&& yum install -y git vim zsh  

