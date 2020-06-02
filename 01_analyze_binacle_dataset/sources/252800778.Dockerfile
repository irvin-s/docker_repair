FROM alpine  
  
RUN apk update && \  
apk upgrade && \  
apk add --update bash dnsmasq && \  
rm -rf /var/cache/apk/*  
  
COPY init ./  
RUN mkdir /etc/dnsmasq  
ENTRYPOINT ./init  

