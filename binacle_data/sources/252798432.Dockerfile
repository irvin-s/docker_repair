FROM debian:jessie  
MAINTAINER dennis@moellegaard.dk  
  
ENV LANG en_US.UTF-8  
ENV LC_ALL C.UTF-8  
ENV LANGUAGE en_US.UTF-8  
COPY build.sh build/  
  
RUN /build/build.sh && rm -r /build  
  
CMD ["su", "-", "-c", "/usr/bin/mutt", "mutt"]  

