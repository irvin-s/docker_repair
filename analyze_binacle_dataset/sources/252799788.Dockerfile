#########################  
# graylog-proxy #  
#########################  
FROM haproxy:1.7-alpine  
  
LABEL maintainer "Sami Pajunen <sami.pajunen@digia.com>"  
  
ENV API_PUBLISH_PORT=8080 \  
BEATS_PUBLISH_PORT=5044 \  
API_SERVER_PORT=8443 \  
BEATS_SERVER_PORT=5044  
  
COPY data/haproxy.cfg /usr/local/etc/haproxy/  

