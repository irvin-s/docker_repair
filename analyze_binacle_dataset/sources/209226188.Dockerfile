FROM node:6.2.1

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

# Build assets
RUN npm run build

# Prune dev dependencies
RUN npm prune --production

EXPOSE 3001

CMD [ "npm", "run", "serve" ]
