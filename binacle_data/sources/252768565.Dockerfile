FROM alpine  
MAINTAINER Anastas Dancha <anapsix@random.io>  
RUN apk upgrade --update && \  
apk add php-cli  
COPY www/* /app/  
WORKDIR /app  
EXPOSE 8080  
CMD ["php","-S","0.0.0.0:8080"]  

