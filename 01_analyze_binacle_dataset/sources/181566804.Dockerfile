FROM node
MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

RUN npm install -g node-static live-server bower grunt-cli
WORKDIR /static
VOLUME /static

EXPOSE 80

# Option 1: Use the simplest server possible
#CMD npm install; bower install --allow-root; static --host-address 0.0.0.0 -p 80 --gzip

# Option 2: Use the live-server that reloads the page if a change is saved in any file
CMD npm install; bower install --allow-root; live-server --host=0.0.0.0 --port=80 --no-browser
