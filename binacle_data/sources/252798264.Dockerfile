FROM java:8  
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -  
RUN apt-get install -y nodejs build-essential  
RUN npm install -g bower@1.7.9 grunt-cli@1.2.0  

