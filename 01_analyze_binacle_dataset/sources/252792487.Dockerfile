FROM ubuntu:16.04  
#Author  
MAINTAINER dangminhtruong  
  
#Work dir  
WORKDIR /app  
ADD . /app  
  
#Install curl  
RUN apt-get update && apt-get install -y curl  
  
# Install Nodejs, Nodemon, Eslint, Babel-.., Yarn  
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \  
&& apt-get install -y nodejs \  
&& npm install -g nodemon eslint babel-eslint eslint-plugin-react yarn  
  
# install packages  
RUN npm install  
  
CMD ["nodemon", "-L"]  
  
EXPOSE 3000

