FROM    nodesource/trusty:4.4

# Install app dependencies
COPY package.json /src/package.json
RUN cd /src; npm install --production

# Bundle app source
COPY . /src

EXPOSE  8000 
VOLUME ["/data"]
CMD ["node", "/src/server.js"]