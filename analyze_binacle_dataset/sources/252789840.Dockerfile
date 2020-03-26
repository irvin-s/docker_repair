FROM callforamerica/debian  
  
MAINTAINER joe <joe@valuphone.com>  
  
ARG APTCACHER_NG_VERSION  
  
ENV APTCACHER_NG_VERSION=${APTCACHER_NG_VERSION:-0.8.0}  
  
LABEL app.aptcacher-ng.version=$APTCACHER_NG_VERSION  
  
ENV HOME=/opt/apt-cacher-ng  
  
COPY build.sh /tmp/  
RUN /tmp/build.sh  
  
COPY entrypoint /  
  
VOLUME ["/var/cache/apt-cacher-ng"]  
  
EXPOSE 3142  
ENV APTCACHER_PORT=3142 \  
APTCACHER_BIND_ADDR=0.0.0.0 \  
APTCACHER_EXPIRE_THRESHOLD=4  
WORKDIR /var/cache/apt-cacher-ng  
  
ENTRYPOINT ["/dumb-init", "--"]  
CMD ["/entrypoint"]  

