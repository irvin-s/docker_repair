FROM alpine  
  
RUN apk update && \  
apk upgrade && \  
apk add --update bash iptables ipset && \  
rm -rf /var/cache/apk/*  
  
RUN mkdir /bypass  
ADD init ./  
ADD clean-rule ./  
ADD clean-ipset ./  
  
ENTRYPOINT ./init  

