FROM ruby:2.4.1  
  
RUN gem install bundler && \  
gem install smashing && \  
curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
apt-get install -y nodejs && \  
apt-get clean && \  
apt-get autoclean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

