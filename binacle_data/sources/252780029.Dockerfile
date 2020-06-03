FROM nginx:stable-alpine  
  
RUN apk add --no-cache openssl ca-certificates bash  
  
ENV DOCKER_TLS_LOG=stdout  
ENV DOCKER_TLS_ERRORS=stderr  
  
ENV DOCKER_TLS_PASSPHRASE=tls_passphrase  
ENV DOCKER_TLS_DNS=localhost  
ENV DOCKER_TLS_HOST=127.0.0.1  
ENV DOCKER_TLS_COUNTRY=CN  
ENV DOCKER_TLS_ORG=gokit.info  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY docker-entrypoint.sh /usr/local/bin/  
  
VOLUME [ "/home/docker", "/etc/nginx/docker" ]  
ENTRYPOINT ["docker-entrypoint.sh"]  
CMD ["nginx"]  
  

