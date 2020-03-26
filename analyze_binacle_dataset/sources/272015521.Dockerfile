FROM node:10.14-alpine

RUN mkdir -p /usr/src/shared
COPY shared/package.json shared/package-lock.json /usr/src/shared/
COPY shared/src /usr/src/shared/src

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY reserve_ca/package.json reserve_ca/package-lock.json reserve_ca/ecosystem.config.js /usr/src/app/
COPY reserve_ca/src /usr/src/app/src

RUN npm install --production
RUN npm install /usr/src/shared
RUN npm install -g pm2

CMD ["pm2-runtime", "start", "ecosystem.config.js", "--env", "production"]
