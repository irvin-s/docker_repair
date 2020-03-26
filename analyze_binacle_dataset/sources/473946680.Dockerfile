FROM nodesource/precise:4.2.3

ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /opt/fe-api && cp -a /tmp/node_modules /opt/fe-api/

WORKDIR /opt/fe-api
ADD . /opt/fe-api

EXPOSE 8686

CMD ["npm", "start"]
