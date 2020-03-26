FROM golang:alpine  
  
RUN \  
apk add --update bash && \  
rm -rf /var/cache/apk/*  
  
ADD https://get.docker.com/builds/Linux/x86_64/docker-1.10.1 /usr/bin/docker  
RUN chmod +x /usr/bin/docker  
  
ENV GO15VENDOREXPERIMENT 1  
VOLUME /go/app  
  
COPY builder.sh /  
RUN chmod +x /builder.sh  
  
RUN mkdir /app  
COPY app/Dockerfile /app/Dockerfile  
  
ENTRYPOINT ["/builder.sh"]  

