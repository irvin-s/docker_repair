FROM node:4-alpine

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json .
RUN npm install && npm cache clean

# Bundle app source
COPY . .

ENV NODE_ENV=production
EXPOSE 3000
CMD [ "npm", "start" ]
