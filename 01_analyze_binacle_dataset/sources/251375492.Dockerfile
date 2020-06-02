FROM node:6.9

# Create app directory
RUN mkdir -p /usr/src/note-loopback
WORKDIR /usr/src/note-loopback

# Install app dependencies
COPY package.json /usr/src/note-loopback
RUN npm install

# Bundle app source
COPY . /usr/src/note-loopback

EXPOSE 3000 50051
CMD [ "node", "." ]
