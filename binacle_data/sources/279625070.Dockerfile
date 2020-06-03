FROM node:alpine

RUN npm i -g pm2 &>/dev/null

RUN mkdir -p /var/www/app
WORKDIR /var/www/app
ADD . /var/www/app
RUN npm i --production &>/dev/null

RUN mkdir -p /var/www/app/src
ADD ./src /var/www/app/src

EXPOSE 5000

CMD ["pm2", "start", "processes.json", "--no-daemon","--silent"]
