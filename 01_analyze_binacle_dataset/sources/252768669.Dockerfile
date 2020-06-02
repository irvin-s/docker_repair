FROM alpine:3.7  
MAINTAINER ancolin  
  
RUN apk update && \  
apk upgrade && \  
apk add \  
php7 \  
php7-simplexml \  
php7-curl \  
tzdata && \  
cp /usr/share/zoneinfo/Japan /etc/localtime && \  
apk del tzdata && \  
rm -rf /var/cache/apk/* && \  
sed -e "s@;date.timezone =@date.timezone = Asia/Tokyo@g" -i /etc/php7/php.ini  
  
COPY app/ /  
RUN chmod +x /entrypoint.php  
ENTRYPOINT ["php", "/entrypoint.php"]  
CMD ["shorter"]  

