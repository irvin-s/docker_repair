# fresh ubuntu  
FROM ubuntu  
  
# update all the packages  
RUN apt-get update  
  
## install important things  
RUN apt-get -yqq install curl git build-essential wget  
  
# install node  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get -yqq install nodejs  
  
# mount current directory as `src` in container, set as working directory  
ADD . /src  
WORKDIR /src  
  
# pass in args as `process.env.arg`  
ARG GITHUB_USER  
ARG GITHUB_TOKEN  
  
# npm install yarn, yarn install dependencies  
RUN npm install -g yarn  
RUN yarn  

