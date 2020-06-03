FROM ubuntu:xenial  
LABEL version="0.0.1"  
MAINTAINER Alexander Akhmetov <akhmetoff@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y ca-certificates  
RUN update-ca-certificates -f  
  
ADD grimd /bin/grimd  
  
EXPOSE 53/udp 53/tcp  
  
CMD /bin/grimd

