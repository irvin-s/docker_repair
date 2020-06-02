FROM debian:stretch-slim  
  
MAINTAINER Dome C. <dome@tel.co.th>  
  
RUN \  
apt-get update \  
&& apt-get install busybox  
  
COPY start.sh /  
COPY .bashrc /root/  
COPY shells /etc  
RUN chmod +x /start.sh  
#ENV TERM screen.xterm-new  
ENV TERM screen-256color  
ENV SHELL=/bin/bash  
  
ENTRYPOINT ["/start.sh"]  
  

