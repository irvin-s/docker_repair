FROM node:6  
# Create app directory  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json .  
# For npm@5 or later, copy package-lock.json as well  
# COPY package.json package-lock.json ./  
RUN npm install phantomjs -g  
RUN npm install gulp -g  
RUN npm install  
  
# Bundle app source  
COPY . .  
  
CMD [ "npm", "start" ]

