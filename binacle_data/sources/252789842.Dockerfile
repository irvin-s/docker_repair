FROM callforamerica/debian  
  
MAINTAINER joe <joe@valuphone.com>  
  
ARG BIGCOUCH_VERSION  
  
ENV BIGCOUCH_VERSION=${BIGCOUCH_VERSION:-0.4.2} \  
ERLANG_VERSION=R14B01  
  
LABEL lang.erlang.version=$ERLANG_VERSION  
LABEL app.bigcouch.version=$BIGCOUCH_VERSION  
  
ENV HOME=/opt/bigcouch  
  
COPY build.sh /tmp/build.sh  
RUN /tmp/build.sh  
  
# bug with docker hub automated builds when interating with root directory  
# ref: https://forums.docker.com/t/automated-docker-build-fails/22831/27  
# COPY entrypoint /entrypoint  
COPY entrypoint /tmp/  
RUN mv /tmp/entrypoint /  
  
ENV BIGCOUCH_LOG_LEVEL=info  
  
VOLUME ["/volumes/bigcouch"]  
  
EXPOSE 4369 5984 5986 11500-11999  
# USER bigcouch  
WORKDIR /opt/bigcouch  
  
ENTRYPOINT ["/dumb-init", "--"]  
CMD ["/entrypoint"]  

