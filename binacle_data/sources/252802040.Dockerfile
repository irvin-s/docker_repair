FROM python:2-alpine  
MAINTAINER "EEA: IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>  
  
ENV PYFLAKES_VERSION=1.6.0  
RUN apk add --no-cache --virtual .run-deps git \  
&& pip install pyflakes==$PYFLAKES_VERSION \  
&& mkdir -p /code  
  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["pyflakes"]  

