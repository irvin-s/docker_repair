FROM microsoft/dotnet:2-sdk  
  
RUN useradd -m app  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
apt-get install -y libgdiplus && \  
apt-get install -y nodejs && \  
npm install -g bower && \  
npm install -g grunt-cli && \  
apt-get clean  

