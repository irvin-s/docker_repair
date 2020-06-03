FROM mhart/alpine-node

WORKDIR /opt
ENTRYPOINT ["node", "monitor.js"]

COPY package.json /opt/package.json
RUN npm install --production

COPY . /opt
