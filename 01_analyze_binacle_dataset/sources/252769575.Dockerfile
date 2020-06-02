FROM ubuntu:14.04  
MAINTAINER Are Pedersen <are@n42.no>  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV DEBCONF_NONINTERACTIVE_SEEN true  
  
RUN apt-get update  
RUN apt-get install -y git golang build-essential ruby ruby-dev gcc  
RUN gem install fpm  
  
RUN mkdir /src  
ADD log-courier.ubuntu.init /src/log-courier.ubuntu.init  
ADD makedeb.sh /src/makedeb.sh  
  
CMD /src/makedeb.sh  

