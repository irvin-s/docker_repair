FROM node

RUN npm install -g bower
RUN npm install -g gulp

WORKDIR /contiv-ui

CMD gulp build
