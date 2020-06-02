FROM mlabouardy/nodejs
MAINTAINER Mohamed Labouardy <mohamed@labouardy.com>

ENV DOCKER_HOST unix:///var/run/docker.sock

# Install app dependencies
COPY package.json /src/package.json
RUN cd /src; npm install

# Bundle app source
COPY . /src

# Expose Port

EXPOSE 3000
CMD ["node","/src/server.js"]
