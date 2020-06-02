FROM elixir:1.4.1  
# Install node & yarn  
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - \  
&& apt-get install -y nodejs \  
&& rm -rf /var/cache/apt \  
&& npm install -g yarn  

