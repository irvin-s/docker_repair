FROM alpine  
  
ARG BUILD_DATE  
ARG VCS_REF  
ARG VERSION  
  
LABEL maintainer "Brian Hewitt <durendal@durendals-domain.com>"  
LABEL org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.name="docker-rubycoind" \  
org.label-schema.description="rubycoind node" \  
org.label-schema.url="https://github.com/Durendal/docker-rubycoind" \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.vcs-url="https://github.com/Durendal/docker-rubycoind" \  
org.label-schema.vendor="rubycoinorg" \  
org.label-schema.version=$VERSION \  
org.label-schema.schema-version="1.0"  
  
ENV BOOST_LIB_SUFFIX=-mt  
  
RUN apk --no-cache --virtual build-dependencies add autoconf \  
git \  
automake \  
build-base \  
libressl \  
libressl-dev \  
libtool \  
protobuf-dev \  
gnupg \  
file \  
zeromq-dev && \  
apk --no-cache add boost \  
boost-dev \  
db-dev \  
libevent-dev && \  
git clone https://github.com/rubycoinorg/rubycoin.git && \  
cd rubycoin/src && \  
make -f makefile.unix && \  
mv rubycoind /usr/local/bin/ && \  
cd ../.. && \  
rm -rf rubycoin && \  
apk del \--purge build-dependencies  
  
VOLUME ["/rubycoin"]  
  
EXPOSE 5937 5938  
  
COPY ["bin", "/usr/local/bin/"]  
COPY ["docker-entrypoint.sh", "/usr/local/bin/"]  
ENTRYPOINT ["docker-entrypoint.sh"]  

