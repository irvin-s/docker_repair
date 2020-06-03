FROM gocd/gocd-agent  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \  
sudo apt-get install -y nodejs && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  

