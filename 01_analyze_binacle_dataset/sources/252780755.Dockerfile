FROM debian:jessie  
MAINTAINER Bruno Adelé "bruno@adele.im"  
USER root  
ENV DEBIAN_FRONTEND noninteractive  
ENV TERM xterm-256color  
ENV DISPLAY :0  
# Upgrade the distribution  
RUN apt-get update && \  
apt-get -yf upgrade && \  
apt-get -yf dist-upgrade && apt-get -y install apt-utils curl nano git  
  
# Clean the cache and unused packages  
RUN apt-get clean  
RUN apt-get autoremove  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
CMD bash  

