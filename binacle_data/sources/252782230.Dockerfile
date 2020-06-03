FROM python:3.6-alpine as builder  
  
RUN apk add --no-cache --update g++ openssl-dev \  
&& pip install m2crypto  
  
FROM python:3.6-alpine  
  
LABEL maintainer="cyclops.zhao@protonmail.com"  
  
ENV SITE_PACKAGES /usr/local/lib/python3.6/site-packages  
  
# add our user and group first to make sure their IDs get assigned  
# consistently, regardless of whatever dependencies get added  
RUN addgroup shadowsocks \  
&& adduser -g Shadowsocks -G shadowsocks -D -H shadowsocks  
  
COPY \--from=builder $SITE_PACKAGES $SITE_PACKAGES  
  
RUN apk add --no-cache --update git libsodium su-exec \  
&& pip install git+https://github.com/shadowsocks/shadowsocks.git@master \  
&& apk del --purge git  
  
COPY docker-entrypoint.sh /usr/local/bin/  
RUN chmod +x /usr/local/bin/docker-entrypoint.sh \  
&& ln -s /usr/local/bin/docker-entrypoint.sh / # backwards compat  
  
EXPOSE 1080 6001 8388  
ENTRYPOINT ["docker-entrypoint.sh"]  
  

