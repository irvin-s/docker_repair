FROM alpine:3.4  
ARG CURATOR_VERSION=5.0.1  
RUN \  
apk add --no-cache --update \  
bash \  
python \  
py-pip \  
sed \  
&& \  
pip install --no-cache-dir \  
elasticsearch-curator==${CURATOR_VERSION} \  
&& \  
mkdir /actions /config  
  
COPY crontab /var/spool/cron/crontabs/root  
COPY templates/* /templates/  
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh  
  
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]  

