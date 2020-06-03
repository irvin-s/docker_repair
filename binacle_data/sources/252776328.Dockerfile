FROM nginx  
MAINTAINER André Bonkowski  
  
RUN apt-get update && apt-get install -y \  
ruby \  
ruby-dev \  
libsqlite3-dev \  
build-essential \  
make \  
g++  
  
RUN gem install mailcatcher --no-ri --no-rdoc  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY start-server.sh /usr/bin/start-server  
RUN chmod +x /usr/bin/start-server  
  
EXPOSE 80  
EXPOSE 1025  
ENTRYPOINT /usr/bin/start-server  

