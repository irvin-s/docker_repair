FROM node:6

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies, assuming npm is already installed on the image
COPY package.json /usr/src/app/
RUN npm install

#app binding to 3000
EXPOSE 3000

# Bundle app source code inside the docker image
COPY . /usr/src/app

CMD [ "node", "flightassist.js" ]
