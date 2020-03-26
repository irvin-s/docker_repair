FROM alpine  
MAINTAINER Simone <chaufnet@gmail.com>  
  
RUN apk --no-cache add lsyncd  
  
VOLUME ["/source", "/target"]  
CMD ["lsyncd", "-nodaemon", "-rsync", "/source", "/target"]  

