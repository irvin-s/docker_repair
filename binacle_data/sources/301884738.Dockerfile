FROM node:latest

RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN npm i -g nodemon sequelize-cli

WORKDIR /var/www/workshop

ADD . /var/www/workshop

RUN yarn install

CMD ["docker/start.sh"]
