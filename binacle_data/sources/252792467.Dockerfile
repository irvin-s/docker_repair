FROM cheggwpt/php7.2-nginx:0.0.2  
LABEL maintainer="Joel Gilley jgilley@chegg.com"  
  
RUN apk --update --no-cache add \  
\--virtual .libreoffice libreoffice && \  
rm -rf /var/cache/apk/*  
  

