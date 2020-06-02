FROM ruby:2.2.5  
# Install node & yarn  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \  
&& apt-get install -y nodejs \  
&& rm -rf /var/cache/apt \  
&& npm install -g yarn  

