# Latest Node.js 4.x LTS
FROM node:argon 

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Bundle app source
COPY . /usr/src/app

RUN npm install

EXPOSE 80 

CMD [ "node", "app.js" ]
