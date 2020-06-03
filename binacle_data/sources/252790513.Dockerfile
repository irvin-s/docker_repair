FROM carina/docker_auth:latest  
MAINTAINER Ash Wilson <smashwilson@gmail.com>  
  
RUN apk add --update jq curl  
COPY rsauth /rsauth  

