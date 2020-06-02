FROM alpine:3.3  
  
RUN apk update && apk add redis nodejs supervisor  
  
ENV PORT 8080  
EXPOSE 8080  
  
ADD . /fon  
WORKDIR /fon  
  
RUN npm install  
  
CMD supervisord --nodaemon --configuration ./supervisord.conf  

