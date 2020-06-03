FROM mhart/alpine-node:6  
MAINTAINER bowwow <bowwow@gmail.com>  
  
WORKDIR /src  
ADD tracker/package.json /src/  
RUN npm install  
ADD tracker /src  
EXPOSE 8000  
CMD ["node", "bin/cmd.js"]  

