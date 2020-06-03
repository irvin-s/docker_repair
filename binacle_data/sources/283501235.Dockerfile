FROM node:8

WORKDIR /src

ADD src/package.json /src/
#install node modules
RUN npm install

# Add app source files
ADD src /src

CMD ["node", "server.js"]
