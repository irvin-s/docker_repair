FROM node:boron

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json yarn.lock /usr/src/app/

RUN yarn --pure-lockfile

# Bundle app source
COPY . /usr/src/app

#Expose port 3001 so the monitor service is reachable
EXPOSE 3001
EXPOSE 8080

CMD ["node", "index.js"]
