FROM armhf/alpine:3.4  
MAINTAINER Scott Mebberson <scott@scottmebberson.com>  
  
# Install nginx  
RUN apk add --update nginx && apk add --update bash &&\  
rm -rf /var/cache/apk/* && \  
chown -R nginx:www-data /var/lib/nginx  
  
# Add the files  
ADD root /  
COPY docker-entrypoint.sh /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["nginx"]  
# Expose the ports for nginx  
EXPOSE 80 443  

