FROM alpine:3.7  
  
ARG uid=1000  
ARG user=scpuser  
  
MAINTAINER Aleksandar Dimitrov <aleks.dimitrov@gmail.com>  
  
RUN apk add \--no-cache openssh-client  
RUN adduser -D -u ${uid} ${user}  
  
USER ${user}  
RUN mkdir -p /home/${user}/.ssh && chown ${user} /home/${user}/.ssh  

