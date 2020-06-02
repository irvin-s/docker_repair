FROM ubuntu:16.04  
MAINTAINER dgc1980 <docker@dgc1980.33mail.com>  
  
ENV HOME /root  
  
CMD ["/etc/init.d/hamachi"]  
  
RUN usermod -u 99 nobody && \  
usermod -g 100 nobody  
  
RUN apt-get update -y && apt-get install -y wget  
  
VOLUME /config  
  
ADD hamachi.sh /etc/init.d/hamachi  
RUN chmod +x /etc/init.d/hamachi  
  

