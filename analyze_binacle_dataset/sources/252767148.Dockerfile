FROM alpine:latest  
MAINTAINER "Aleksandr Derbenev <ya.alex-ac@yandex.com>"  
RUN apk --update add git nodejs && rm -rf /var/cache/apk/* && \  
npm install -g bower grunt-cli && \  
echo '{ "allow_root": true }' > /root/.bowerrc  
  

