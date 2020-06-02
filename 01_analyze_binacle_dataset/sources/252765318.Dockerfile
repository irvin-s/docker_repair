FROM alpine:3.7  
LABEL maintainer="tnguen@alfabank.ru"  
  
COPY entrypoint.sh /  
COPY stunnel.conf.template /  
  
RUN apk add --update --no-cache openssl stunnel stunnel  
  
ENV BUILD_DEPS="gettext" \  
RUNTIME_DEPS="libintl"  
RUN set -x && \  
apk add --update $RUNTIME_DEPS && \  
apk add --virtual build_deps $BUILD_DEPS && \  
cp /usr/bin/envsubst /usr/local/bin/envsubst && \  
apk del build_deps  
  
ENTRYPOINT ["/entrypoint.sh"]  

