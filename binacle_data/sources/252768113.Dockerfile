FROM alpine:latest  
  
RUN apk add \--no-cache \  
iptables \  
ppp \  
pptpd \  
tini  
  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]  
  
CMD ["pptpd-chap"]  
  
EXPOSE 1723  

