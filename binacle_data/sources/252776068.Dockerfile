FROM gliderlabs/alpine  
ADD run.sh /run.sh  
VOLUME /data  
RUN apk update && apk add git  
CMD ["/bin/sh", "/run.sh"]  

