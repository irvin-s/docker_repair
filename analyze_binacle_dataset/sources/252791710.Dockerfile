FROM alpine:3.4  
MAINTAINER Alexandre Flament <alex@al-f.net>  
  
ENV NGHTTP2_VERSION 1.23.1  
ENV SPDYLAY_VERSION 1.4.0  
COPY *.sh /build/  
  
RUN /build/build.sh  

