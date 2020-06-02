FROM golang:onbuild  
RUN curl -sL https://deb.nodesource.com/setup | bash -  
RUN apt-get install -y nodejs  
  
# Install bower  
RUN npm install -g bower vulcanize  
RUN bower install --allow-root  
RUN vulcanize static/app.html > static/index.html  

