FROM alpine:3.4  
RUN apk --update add git python && \  
git clone \--depth=1 https://github.com/rembo10/headphones.git /headphones  
  
ADD start.sh /start.sh  
  
VOLUME ["/data"]  
EXPOSE 8181  
CMD ["/start.sh"]  

