FROM debian  
  
MAINTAINER Frederic Darmstädter <docker@darmstaedter.org>  
  
ENV GITHUB_USERNAME darmstaedter  
  
RUN apt-get update && apt-get install -y wget openssh-server  
RUN mkdir -p /root/.ssh && cd /root/.ssh && \  
wget https://github.com/${GITHUB_USERNAME}.keys -O authorized_keys  
CMD service ssh restart && /bin/bash  

