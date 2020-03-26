FROM debian:jessie  
MAINTAINER Marek Bartík <bartimar6 at gmail.com>  
RUN apt-get update && \  
apt-get install -y --no-install-recommends steghide && \  
apt-get clean autoclean && \  
apt-get autoremove -y --purge && \  
rm -rf /var/lib/{apt,dpkg,cache,log}/  
ENTRYPOINT ["steghide"]  

