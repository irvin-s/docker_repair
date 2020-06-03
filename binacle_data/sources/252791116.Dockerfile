FROM alpine  
  
MAINTAINER mangege <cxh116@126.com>  
  
RUN apk add --update bash && rm -rf /var/cache/apk/*  
  
RUN apk add --update iperf && rm -rf /var/cache/apk/*  
  
EXPOSE 4444  
CMD iperf -s -p 4444  

