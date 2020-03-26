FROM starefossen/ruby-node:2-5  
MAINTAINER Daniel Anggrianto <d.anggrianto@gmail.com>  
  
# install compass  
RUN gem install compass  
  
# grunt and bower  
RUN npm install -g grunt-cli bower

