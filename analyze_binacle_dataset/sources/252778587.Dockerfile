FROM alpine:latest  
MAINTAINER brycethomsen  
RUN apk update && apk add nodejs git  
RUN git clone https://github.com/Freeboard/freeboard.git  
RUN npm install grunt http-server -g  
RUN cd /freeboard && npm install && grunt  
EXPOSE 8080 8080  
ENTRYPOINT http-server /freeboard  

