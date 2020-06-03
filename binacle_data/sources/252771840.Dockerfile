FROM java  
MAINTAINER Frederik Hahne <frederik.hahne@gmail.com>  
  
# install node.js  
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -  
RUN apt-get install -y nodejs python g++ build-essential  
  
# install yeoman  
RUN npm install -g yo  
  
# install bower  
RUN npm install -g bower  
  
#install gulp  
RUN npm install -g gulp  
  
# add .gradle dependencies  
ADD static/.m2 /root/.m2  
  
# add node_modules dependecies  
ADD static/node_modules /root/node_modules  

