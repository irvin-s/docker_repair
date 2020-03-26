FROM phusion/baseimage:0.9.19  
MAINTAINER Ben White <ben@cuckoo.org>  
  
#########################################  
## ENVIRONMENTAL CONFIG ##  
#########################################  
# Set correct environment variables  
ENV USER_ID="0" \  
GROUP_ID="0" \  
TERM="xterm"  
# Use baseimage-docker's init system  
CMD ["/sbin/my_init"]  
  
#########################################  
## RUN INSTALL SCRIPT ##  
#########################################  
ADD ./files /files  
#ADD https://jaxx.io/files/1.1.7/Jaxx-v1.1.7-linux-x64.tar.gz /root  
ADD https://jaxx.io/files/1.2.4/Jaxx-v1.2.4-linux-x64.tar.gz /root  
RUN mkdir /opt/jaxx && \  
tar -zxf /root/Jaxx-v1.2.4-linux-x64.tar.gz --strip=1 -C /opt/jaxx  
# tar -zxf /root/Jaxx-v1.1.7-linux-x64.tar.gz --strip=1 -C /opt/jaxx  
RUN sync && /bin/bash /files/tmp/install.sh  
RUN ln -s /config /root/.config/Jaxx  
  
#########################################  
## EXPORTS AND VOLUMES ##  
#########################################  
VOLUME /data /config  
EXPOSE 8280 8239  

