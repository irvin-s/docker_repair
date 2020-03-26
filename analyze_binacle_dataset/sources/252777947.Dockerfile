FROM node:latest  
  
MAINTAINER Angel Pino <angelmpino87@yahoo.com>  
  
RUN echo "Installing Bower" \  
&& npm install -g bower  
  
RUN echo "Installing Gulp" \  
&& npm install -g gulp  
  
RUN echo "Installing Karma-Cli" \  
&& npm install -g karma-cli  
  
RUN echo "Installing Nodemon" \  
&& npm install -g nodemon  
  
RUN echo "Installing Typings" \  
&& npm install -g typings  
  
RUN echo "Installing Typescript" \  
&& npm install -g typescript  
  
RUN echo "Installing http-server" \  
&& npm install -g http-server  
  
RUN echo "Installing angular-cli" \  
&& npm install -g angular-cli \  
&& ng set \--global warnings.packageDeprecation=false  
  
EXPOSE 8080  
WORKDIR /home  
  

