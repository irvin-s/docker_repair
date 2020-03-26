FROM alpine:3.4  
RUN apk update && \  
apk upgrade && \  
apk add --update bash ssmtp && \  
rm -rf /var/cache/apk/*  
  
RUN mkdir ssmtp  
ADD init ./  
ENTRYPOINT ./init  

