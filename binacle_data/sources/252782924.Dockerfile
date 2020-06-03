FROM python:2-alpine3.6  
MAINTAINER David Verdejo <david.verdejo@bluekiri.com>  
  
RUN apk update && \  
apk upgrade && \  
apk add --update --no-cache \  
# for build  
build-base \  
# for healthcheck  
curl \  
# for thumbor  
curl-dev \  
#zlib-dev \  
jpeg-dev \  
openssl-dev && \  
pip install --use-wheel --no-cache-dir \  
envtpl==0.5.3 \  
#error png in 6.3.x - https://github.com/thumbor/thumbor/issues/943  
#thumbor==6.3.2  
thumbor==6.2.0 && \  
apk del \  
build-base \  
curl-dev && \  
#http://thumbor.readthedocs.io/en/latest/plugins.html  
rm -rf /var/cache/apk/* && \  
rm -rf /tmp/*  
  
ENV HOME /usr/src/app  
ENV SHELL bash  
ENV WORKON_HOME /usr/src/app  
WORKDIR /usr/src/app  
  
COPY conf/thumbor.conf.tpl /usr/src/app/thumbor.conf.tpl  
COPY docker-entrypoint.sh /  
  
HEALTHCHECK \--interval=5s --timeout=3s \  
CMD curl -f http://localhost:8000/healthcheck || exit 1  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["thumbor"]  
  
EXPOSE 8000  

