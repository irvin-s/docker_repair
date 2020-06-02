FROM alpine  
  
MAINTAINER Joe Black <joe@valuphone.com>  
  
LABEL os.name="alpine" \  
lang.version="3.4"  
  
LABEL app.name="squid" \  
app.version="3.5.19-r1"  
  
ENV ALPINE_VERSION=3.4  
ENV SQUID_VERSION=3.5.19-r1 \  
GOSU_VERSION=1.10 \  
DUMB_INIT_VERSION=1.1.3  
ENV HOME=/var/cache/squid  
  
COPY build.sh /tmp/build.sh  
RUN /tmp/build.sh  
  
COPY entrypoint /entrypoint  
COPY squid.conf /etc/squid/squid.conf  
  
VOLUME ["/var/cache/squid"]  
  
EXPOSE 3128  
WORKDIR /home/squid  
  
ENTRYPOINT ["/dumb-init", "--"]  
CMD ["/entrypoint"]  

