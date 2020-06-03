FROM mhart/alpine-node:4  
MAINTAINER Tim Lucas <tim@buildkite.com>  
  
ADD . /usr/src/app/  
  
WORKDIR /usr/src/app  
  
RUN npm install \  
&& npm prune --production  
  
EXPOSE 8080  
CMD ["npm", "start"]  

