ARG BUILD_FROM
FROM $BUILD_FROM

USER root
ENV LANG C.UTF-8
RUN apk add --no-cache nodejs nodejs-npm
RUN npm install pm2 -g

WORKDIR /usr/src/hassio_meross

COPY package*.json ./

RUN npm install

COPY app.js .
COPY lib /usr/src/hassio_meross/lib

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
