FROM phusion/baseimage:0.9.19  
MAINTAINER Anton Zagorskii <amberovsky@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
ADD ./ /build-layerzero  
RUN /build-layerzero/layerzero.sh && rm -rf /build-layerzero  

