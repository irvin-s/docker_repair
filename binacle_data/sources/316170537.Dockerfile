FROM node:8.1

RUN npm install -g yarn

RUN apt-get update
RUN apt-get -y install zip unzip

COPY entrypoint.sh /usr/bin/entrypoint.sh

ENV PATH="/var/www/html/node_modules/.bin:${PATH}"
WORKDIR /var/www/html

ENTRYPOINT ["entrypoint.sh"]
