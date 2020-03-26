FROM python:2.7-alpine3.6  
ENV CRM_SOURCE=https://github.com/eea/ClueReleaseManager/archive/master.zip \  
EGGS_PATH=/var/local/eggrepo  
  
## install egg server  
RUN pip install $CRM_SOURCE \  
&& apk add --no-cache su-exec bash \  
&& addgroup -g 500 cluerelmgr \  
&& adduser -S -D -G cluerelmgr -u 500 cluerelmgr  
  
COPY docker-entrypoint.sh /  
  
WORKDIR $EGGS_PATH  
VOLUME $EGGS_PATH  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["cluerelmgr-server", "-p", "9090", "-b", "/var/local/eggrepo/files"]  

