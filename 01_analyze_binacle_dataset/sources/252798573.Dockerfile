FROM alpine:3.4  
  
RUN apk add \--no-cache curl  
  
ADD shared.sh /opt/bin/shared.sh  
ADD create-api.sh /opt/bin/create-api.sh  
ADD delete-api.sh /opt/bin/delete-api.sh  
ENV KONG_HOST kong.openparse  
ENV KONG_ADMIN_PORT 8001  
ENV API_NAME test  
ENV API_PATH /test  
ENV API_UPSTREAM_HOST parse-dashboard.openparse  
ENV API_UPSTREAM_PORT 4040  
ENV API_UPSTREAM_PATH /  
ENV API_STRIP_REQ_PATH false  
ENV API_PRESERVE_HOST false  
ENV API_PIWIK_ENDPOINT ""  
ENV API_AUTH_USERNAME ""  
ENV API_AUTH_PASSWORD ""  
ENV API_RATE_LIMIT ""  
ENV API_LIMIT_REQUEST_SIZE ""  

