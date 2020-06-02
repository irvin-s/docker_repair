FROM node:4.3.1-wheezy  
  
RUN npm install -g protractor  
  
WORKDIR /  
  
ADD https://saucelabs.com/downloads/sc-latest-linux.tar.gz /  
RUN tar -xzf sc-latest-linux.tar.gz  
  
COPY conf.js /  
  
COPY entrypoint.sh /  
RUN chmod +x /entrypoint.sh  
  
CMD /entrypoint.sh  

