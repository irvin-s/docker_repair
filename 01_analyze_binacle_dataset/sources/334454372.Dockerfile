#For raspberry pi computers
# FROM arm32v7/node
#For regular ubuntu
FROM node:latest

# confirm install
RUN node -v
RUN npm -v

RUN apt-get update && rm -rf /var/lib/apt/lists*
#RUN apt-get install vim
RUN npm install webpack -g


# create working directory
RUN mkdir -p /usr/app
WORKDIR /usr/app

# install app dependencies
COPY package*.json /usr/app/
RUN npm install

# FOR production 
# RUN npm install --only=production

# Bundle app source
COPY . /usr/app

# Change to script dir, add execute permissions, run scripts
WORKDIR /usr/app/utilities
RUN chmod +x ./fileStructureScript.js
RUN chmod +x ./directoryScript.js
RUN chmod +x ./thumbnailScript.js
RUN chmod +x ./packageScript.js
# Run scripts
RUN node ./fileStructureScript.js
RUN node ./directoryScript.js
RUN node ./thumbnailScript.js
RUN node ./packageScript.js

RUN pwd
#RUN ["node", "./utilities/directoryScript.js"]
#RUN ["node", "./utilities/thumbnailScript.js"]

EXPOSE 3000
CMD ["npm", "start"]
RUN ls
