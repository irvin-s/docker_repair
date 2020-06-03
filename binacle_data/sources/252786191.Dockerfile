FROM ubuntu:14.04  
MAINTAINER Dmitry Romanov "dmitry.romanov85@gmail.com"  
RUN ["apt-get", "update"]  
RUN ["apt-get", "-y", "install", "openssl"]  
  
COPY gost-for-openssl /bin/gost-for-openssl  
RUN \  
gost-for-openssl  
  
RUN ["mkdir", "/keys"]  
WORKDIR /keys  
  
CMD ["openssl"]  

