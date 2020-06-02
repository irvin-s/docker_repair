FROM composer  
LABEL maintainer="aleksandar.kasabov@gmail.com"  
  
RUN apk update && \  
docker-php-ext-install pdo_mysql && \  
apk add libpng-dev && \  
docker-php-ext-install gd && \  
rm -f /var/cache/apk/*  
  
VOLUME /app  
WORKDIR /app  
  
ENV APP_ENV=docker  
ENV APP_DEBUG=true  
  
EXPOSE 8000  
COPY docker-entrypoint.bash /docker-entrypoint.bash  
ENTRYPOINT ["/docker-entrypoint.bash"]  
CMD ["run"]  

