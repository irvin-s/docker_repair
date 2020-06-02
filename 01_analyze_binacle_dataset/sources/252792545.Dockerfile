FROM alpine:latest  
  
RUN apk add --no-cache squid stunnel openssl  
COPY stunnel.conf /etc/stunnel/  
COPY entrypoint.sh /  
  
EXPOSE 8080  
CMD ["/entrypoint.sh"]  

