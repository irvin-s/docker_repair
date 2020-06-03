FROM ubuntu:16.04  
MAINTAINER Aleksandr Behskenadze <beshkenadze@gmail.com>  
COPY scripts /usr/src/scripts  
COPY transmission.sh /usr/bin/  
RUN cd /usr/src && \  
./scripts/apt.sh && \  
./scripts/libevent.sh && \  
./scripts/zlib.sh && \  
./scripts/libcurl.sh && \  
./scripts/transmission.sh && \  
./scripts/clean.sh && \  
./scripts/setup.sh && \  
rm -rf /usr/src  
  
EXPOSE 9091 51413/tcp 51413/udp  
  
ENTRYPOINT ["/usr/bin/transmission.sh"]

