FROM alpine:latest  
  
MAINTAINER Andrew A. Smith <andy@tinnedfruit.org>  
  
RUN apk add --update sysstat nmap-ncat && rm -rf /var/cache/apk/*  
  
ADD cpu-agent.awk /  
  
EXPOSE 40000  
CMD ncat -p 40000 --send-only -lkc "sar -u 1 1 | awk -f cpu-agent.awk"  

