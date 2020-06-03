FROM debian:jessie  
MAINTAINER Andrew Watts <ahwatts@gmail.com>  
  
RUN apt-get update && \  
apt-get -y upgrade && \  
apt-get -y install build-essential wget sysstat && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN cd /usr/local/src && \  
wget http://bogomips.org/cmogstored/files/cmogstored-1.5.0.tar.gz && \  
tar -xzf cmogstored-1.5.0.tar.gz && \  
cd cmogstored-1.5.0 && \  
./configure && \  
make && \  
make install && \  
cd .. && \  
rm -rf cmogstored*  
  
ADD entrypoint.sh /entrypoint.sh  
  
RUN useradd -s /bin/bash -m -c "mogstored user" mogstored && \  
mkdir -p /var/mogdata && \  
chmod 0755 /entrypoint.sh && \  
chown mogstored:mogstored /var/mogdata  
  
VOLUME ["/var/mogdata"]  
EXPOSE 7500 7501  
WORKDIR /  
USER mogstored  
CMD ["/entrypoint.sh"]  

