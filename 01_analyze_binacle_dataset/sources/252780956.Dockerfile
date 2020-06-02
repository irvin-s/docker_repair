FROM debian:wheezy  
MAINTAINER guillermo@artesanoweb.es  
RUN apt-get update && apt-get -y install man funny-manpages && apt-get clean  
ENTRYPOINT ["/usr/bin/man"]  
CMD ["ls"]  

