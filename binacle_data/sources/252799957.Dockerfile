FROM dikunix/docker-gitlab-runner-alpine:latest  
  
MAINTAINER Oleks <oleks@oleks.info>  
  
USER root  
  
RUN apk --no-cache add zip unzip git  
  
USER docker  

