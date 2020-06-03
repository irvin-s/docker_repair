FROM golang:1.10-alpine  
  
COPY run.sh /  
  
RUN set -ex && \  
apk add --no-cache git mercurial  
  
ENTRYPOINT ["/run.sh"]  

