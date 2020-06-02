FROM node:latest

RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN npm i -g typescript ts-node

WORKDIR /var/www/lingviny-api

ADD . /var/www/lingviny-api

RUN yarn install

EXPOSE 3000

CMD ["docker/start.sh"]

