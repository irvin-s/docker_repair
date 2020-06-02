FROM alpine:latest  
  
RUN set -ex \  
&& apk add --no-cache py-pip xz bzip2 gzip \  
&& pip install s3cmd  
  
ADD backup.sh /  
  
CMD ["/backup.sh"]  

