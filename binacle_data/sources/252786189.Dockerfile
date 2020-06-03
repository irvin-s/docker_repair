FROM alpine:latest  
MAINTAINER Dmitry Romanov "dmitry.romanov85@gmail.com"  
RUN ["apk", "update"]  
  
RUN ["apk", "add", "icecast"]  
VOLUME ['/etc/icecast2/icecast.xml']  
  
CMD ['/usr/bin/icecast -c /etc/icecast2/icecast.xml']  

