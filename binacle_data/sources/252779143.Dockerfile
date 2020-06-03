FROM alpine:3.7  
VOLUME /etc/htpasswd.d  
COPY entrypoint.sh /  
  
RUN apk add --no-cache apache2-utils  
  
ENTRYPOINT [ "/entrypoint.sh" ]  
CMD [ "sh" ]

