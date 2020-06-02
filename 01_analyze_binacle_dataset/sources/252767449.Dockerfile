FROM alpine:latest  
  
MAINTAINER alex alexwhen@gmail.com  
  
RUN apk --update add nodejs  
  
RUN echo "registry = https://registry.npm.taobao.org">/root/.npmrc  
  
EXPOSE 80  
CMD [ "node" ]  

