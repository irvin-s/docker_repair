FROM alpine  
  
COPY go-webdav /bin/  
VOLUME /webdav/root  
VOLUME /webdav/log  
  
CMD go-webdav

