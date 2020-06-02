FROM node:latest
EXPOSE 3000

RUN mkdir /data
WORKDIR /data

COPY package.json /data
RUN cd /data && npm install --production

COPY html-pdf-server.js /data
COPY views /data/views

HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 1

CMD [ "node", "html-pdf-server.js" ]