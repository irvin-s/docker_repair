FROM alpine  
MAINTAINER Cell <maintainer.docker.cell@outer.systems>  
  
RUN apk add --update --no-progress bash openssh &&\  
rm -rf /var/cache/apk/*  
COPY start.sh /  
  
ENTRYPOINT ["/start.sh"]  
  

