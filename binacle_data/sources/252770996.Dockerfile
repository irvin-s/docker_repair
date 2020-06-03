FROM alpine:3.3  
MAINTAINER "gabo" <aguamala@deobieta.com>  
RUN apk add --update lsyncd bash py-pip &&\  
pip install --upgrade pip &&\  
pip install s3cmd &&\  
rm -rf /var/cache/apk/*  
  
COPY s3cfg-sample /s3cfg-sample  
  
COPY lsyncd-backup.conf /lsyncd-backup.conf  
COPY lsyncd-sync.conf /lsyncd-sync.conf  
  
COPY docker-entrypoint.sh /entrypoint.sh  
  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["lsyncd","/lsyncd.conf"]  

