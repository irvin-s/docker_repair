FROM node

ADD . /usr/src/app
WORKDIR /usr/src/app

# install your application's dependencies
RUN npm install

# replace this with your application's default port
EXPOSE 80

# replace this with your main "server" script file
CMD [ "node_modules/.bin/pogo", "index.pogo" ]
