FROM node  
MAINTAINER Attila Szeremi <attila+webdev@szeremi.com>  
RUN mkdir /src  
WORKDIR /src  
RUN cd /src  
# Copy just the package.json and yarn.lock files file as a cache step.  
COPY package.json /src/package.json  
COPY yarn.lock /src/yarn.lock  
# The preinstall script is needed for yarn install  
COPY tools/scripts/preinstall.js /src/tools/scripts/preinstall.js  
  
# Install yarn and install packages with it.  
RUN npm i yarn -g && yarn install  
  
# Now copy the rest of the files.  
COPY . .  
  
RUN npm run build  
EXPOSE 1337  
CMD ["npm", "run", "start"]  

