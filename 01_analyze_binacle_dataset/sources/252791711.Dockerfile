FROM debian:stretch-slim  
  
MAINTAINER Alexandre Flament <alex@al-f.net>  
  
ENV NGHTTP2_VERSION 1.28.0  
ENV SPDYLAY_VERSION 1.4.0  
COPY *.sh /build/  
  
RUN /build/build.sh  

