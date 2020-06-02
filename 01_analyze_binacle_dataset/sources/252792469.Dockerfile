FROM cheggwpt/php7:1.1.6  
  
RUN apk \--update \--no-cache add \  
\--virtual .libreoffice libreoffice && \  
rm -rf /var/cache/apk/*  

