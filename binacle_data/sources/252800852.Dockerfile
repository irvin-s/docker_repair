FROM alpine:latest  
RUN apk update  
RUN apk add nodejs git  
RUN npm i mocha -g  
RUN npm i gulp -g  

