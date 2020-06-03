FROM docker:latest  
  
MAINTAINER Christof Marti <chrmarti@microsoft.com>  
  
RUN apk update  
RUN apk add tmux openssh-client

