FROM debian:stretch-slim  
  
RUN echo 'deb http://ftp.debian.org/debian stretch-backports main' > \  
/etc/apt/sources.list.d/stretch-backports.list  
  
RUN apt-get update && \  
apt-get --no-install-recommends -y -t stretch-backports \  
install python-simplejson \  
lava-tool \  
git && \  
rm -rf /var/lib/apt/lists/*  
  
WORKDIR /work  
  
ENTRYPOINT ["lava-tool"]  

