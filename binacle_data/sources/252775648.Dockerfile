FROM blendle/dind-ruby  
MAINTAINER Pieter Nicolai <pieter@blendle.com>  
  
ENV DOCKERSOCKET unix:///var/run/docker.sock  
ENV DEPLOY_ENDPOINT /  
  
WORKDIR /usr/src/app  
  
COPY . /usr/src/app  
  
RUN chmod +x deploy.sh  
RUN bundle install  
  
EXPOSE 8888  
ENTRYPOINT ruby docker-hooker.rb  

