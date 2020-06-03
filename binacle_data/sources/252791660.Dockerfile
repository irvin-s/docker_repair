FROM markadams/chromium-xvfb  
  
RUN apt-get update && apt-get install -y curl  
  
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -  
RUN apt-get install -y nodejs git && npm install -g npm@latest  
RUN npm install -g @angular/cli  
  
WORKDIR /usr/src/app  
  

