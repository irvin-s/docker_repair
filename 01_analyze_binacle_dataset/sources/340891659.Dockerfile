FROM node:6

WORKDIR /opt/app

ENV NPM_CONFIG_LOGLEVEL warn
RUN npm install
RUN npm install -g nodemon

# COPY . /opt/app

EXPOSE 3000
CMD [ "nodemon", "-L", "/opt/app/bin/www" ]
