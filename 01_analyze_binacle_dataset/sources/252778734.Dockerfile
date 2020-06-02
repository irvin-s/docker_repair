FROM node:5.10.0  
# install ember-cli and bower  
RUN npm install -g ember-cli  
RUN npm install -g bower  
RUN npm install -g junit-viewer  
  
RUN apt-get update && apt-get -y install sudo ruby expect python-pip  
  
RUN pip install awscli  
  
# install heroku toolbelt  
RUN wget -O- https://toolbelt.heroku.com/install.sh | sh  
  

