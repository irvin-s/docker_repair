FROM passbolt/passbolt:2.0.0-rc2-alpine  
  
RUN apk update && \  
apk add postgresql-client && \  
apk add php5-pdo_pgsql && \  
rm -rf /var/cache/apk/*  
  
COPY nginx.conf /etc/nginx/conf.d/default.conf  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
RUN chmod a+x /docker-entrypoint.sh  
CMD ["/docker-entrypoint.sh"]  

