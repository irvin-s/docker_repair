FROM python:2-alpine  
MAINTAINER "EEA: IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>  
  
ENV PYLINT_VERSION=1.7.2  
RUN apk add --no-cache --virtual .run-deps git \  
&& pip install pylint==$PYLINT_VERSION \  
&& mkdir -p /code  
  
COPY pylint.cfg /etc/pylint.cfg  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["pylint"]  

