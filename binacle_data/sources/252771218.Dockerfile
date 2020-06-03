FROM debian:wheezy  
  
MAINTAINER Romain Fihue <romain.fihue@gmail.com>  
  
RUN apt-get update  
  
RUN apt-get install -y ruby ruby-dev redis-server  
RUN apt-get install -y build-essential  
RUN gem install redis mechanize nokogiri  
  
ADD launch-skrapy.sh /root/launch-skrapy.sh  
COPY skrapy /root/skrapy  
  
WORKDIR /root/skrapy  
  
VOLUME /root/skrapy/done  
  
CMD ./launch-skrapy.sh  

