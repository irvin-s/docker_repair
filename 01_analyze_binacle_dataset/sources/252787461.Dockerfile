FROM node:6  
MAINTAINER Fabian Köster <fabian.koester@bringnow.com>  
  
# Set timezone to Europe/Berlin  
ENV TZ=Europe/Berlin  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
  
# Set workdir  
WORKDIR src  
  
# Copy over package.json  
ADD package.json ./  
  
# Install dependencies  
RUN npm install --silent  
  
# Copy over remaining sources  
ADD . ./  
  
CMD npm start  
EXPOSE 8080  

