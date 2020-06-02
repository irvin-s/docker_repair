FROM ubuntu  
RUN apt-get -y update && \  
apt-get -y upgrade && \  
apt-get -y install bird && \  
apt-get -y autoremove --purge && \  
apt-get -y clean && \  
rm -rf /var/lib/apt/lists/* && \  
rm -rf /tmp/* && \  
mkdir /run/bird  
ENTRYPOINT ["/usr/sbin/bird"]  

