FROM alpine:3.6  
  
# Install our basic tools ssh & rsync  
RUN apk update && apk add openssh-client bash rsync git  
  
# Disable host key checking for ssh  
RUN mkdir /root/.ssh  
COPY config /root/.ssh/config

