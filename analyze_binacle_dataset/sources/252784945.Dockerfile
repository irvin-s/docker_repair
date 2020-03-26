FROM alpine  
MAINTAINER Coderaiser  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
RUN apk update && \  
apk add --no-cache e2fsprogs-extra && \  
apk add --no-cache util-linux && \  
rm -rf /usr/include /tmp/* /var/cache/apk/*  
  
COPY . /usr/src/app  
  
WORKDIR /root  
EXPOSE 8000  
ENTRYPOINT ["/bin/sh", "/usr/src/app/bin/loop.sh"]  
  

