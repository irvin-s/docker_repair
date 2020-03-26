FROM selenium/standalone-chrome  
  
#===================  
# Install Node  
#===================  
RUN sudo apt-get -qqy update && sudo apt-get install -y curl \  
&& curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - \  
&& sudo apt-get install -y nodejs \  
&& sudo rm -rf /var/lib/apt/lists/*  
  
#===================  
# Install Nightwatch  
#===================  
RUN mkdir home/seluser/nightwatch  
WORKDIR home/seluser/nightwatch  
COPY package.json ./  
RUN npm install  

