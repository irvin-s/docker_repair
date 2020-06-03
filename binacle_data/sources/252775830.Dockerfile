FROM alpine:3.3  
MAINTAINER Ryan Bourgeois <bluedragonx@gmail.com>  
  
VOLUME /tmp  
RUN mkdir -p /tmp/httping  
ADD httping.go /tmp/httping/  
  
ENV GOBIN=/usr/bin/  
RUN apk add --no-cache build-base go && \  
cd /tmp/httping && \  
go install -ldflags "-linkmode external -extldflags -static" && \  
apk del --purge build-base go && \  
rm -rf /var/cache/apk/* /tmp/*  
  
ENTRYPOINT ["httping"]  
EXPOSE 80  

