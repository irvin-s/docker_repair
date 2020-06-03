FROM ubuntu:14.04  
MAINTAINER Antonio Manuel Hernández Sánchez  
  
RUN apt-get update && apt-get install -y \  
ruby-dev \  
make  
  
RUN gem install listen  
RUN gem install compass  
RUN gem install compass-core  
  
VOLUME /src  
  
WORKDIR /src  
  
ENTRYPOINT [ "compass" ]  

