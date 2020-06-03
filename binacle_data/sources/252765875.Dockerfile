FROM ruby:2.1  
MAINTAINER 42nerds - Inh. Julian Kaffke <info@42nerds.com>  
  
RUN curl -sL https://deb.nodesource.com/setup_5.x > install_node.sh && \  
bash install_node.sh && \  
rm -f install_node.sh && \  
apt-get install -y nodejs build-essential && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN npm install -g gulp bower  
RUN gem install middleman middleman-deploy  

