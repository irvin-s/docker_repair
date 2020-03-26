FROM alpine:latest  
  
MAINTAINER Afranio Martins <afranioce@gmail.com>  
  
ENV DEPLOY_PUBLIC_DIR ''  
ENV DEPLOY_PROJECT_PATH ''  
ENV DEPLOY_PROJECT_DIR ''  
RUN apk update \  
&& apk add --no-cache git bash  

