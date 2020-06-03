FROM debian:wheezy  
  
RUN apt-get update  
  
RUN apt-get install -y curl  
RUN curl -sL https://deb.nodesource.com/setup | bash -  
RUN apt-get install -y nodejs  
  
RUN npm install -g coffee-script  
  
CMD cd /assets && coffee -o js/ -cw coffee/  

