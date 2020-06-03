FROM node:latest

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Install web dependencies
RUN npm install -g webmodules && wpm install

# Bundle app source
COPY . /usr/src/app

ENV NODE_ENV=production

# Build assets
RUN npm run dist

EXPOSE 3001

CMD [ "npm", "start" ]

