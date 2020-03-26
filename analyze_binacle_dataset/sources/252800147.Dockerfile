FROM alpine:3.3  
MAINTAINER David de los Santos Boix <davsanboi@alum.us.es>  
RUN apk upgrade \--update && apk add nodejs && apk add openjdk8-jre  
WORKDIR /app  
COPY *.sh /  
CMD ["/entrypoint.sh"]  

