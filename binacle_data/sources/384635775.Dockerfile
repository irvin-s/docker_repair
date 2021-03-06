# Run with: docker run -d -i --env-file ./env.list containerid

FROM node:6.11

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

CMD [ "node", "main.js" ]
