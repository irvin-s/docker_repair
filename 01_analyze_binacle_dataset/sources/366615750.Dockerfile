FROM node:4.3.1

WORKDIR /code

COPY package.json bower.json .bowerrc /code/

RUN npm install && \
  npm install -g bower && \
  npm install -g karma-cli && \
  npm install -g gulp && \
  npm install -g cordova ionic ios-sim && \
  bower install --allow-root

COPY . /code

EXPOSE 8100
CMD ionic serve --address `/sbin/ip route|awk '/scope/ { print $9 }'`
