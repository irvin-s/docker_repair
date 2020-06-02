FROM ubuntu:14.04.2  
MAINTAINER Amitoj Setia <asetia@juniper.net>  
  
RUN apt-get update  
RUN apt-get -y install wireshark  
  
CMD ["wireshark"]

