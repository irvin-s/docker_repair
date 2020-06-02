FROM debian:jessie  
MAINTAINER dennis@moellegaard.dk  
  
VOLUME ["/weechat/"]  
  
COPY build.sh build/  
  
ENV LANG en_US.UTF-8  
ENV LC_ALL C.UTF-8  
ENV LANGUAGE en_US.UTF-8  
RUN echo "Europe/Copenhagen" | tee /etc/timezone  
  
RUN dpkg-reconfigure --frontend noninteractive tzdata  
  
RUN /build/build.sh && rm -r /build  
  
ENV TERM xterm-256color  
  
CMD ["/usr/bin/weechat", "-d", "/weechat"]  

