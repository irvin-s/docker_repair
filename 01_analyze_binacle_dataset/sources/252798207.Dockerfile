FROM maven:3.5-jdk-8  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash \  
&& apt-get install -y --no-install-recommends \  
ant-optional \  
nodejs \  
&& rm -rf /var/lib/apt/lists/* \  
&& npm install --global bower \  
&& echo '{ "allow_root": true }' > /root/.bowerrc  

