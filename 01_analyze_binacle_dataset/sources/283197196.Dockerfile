FROM node:8
WORKDIR /root
ENV HOME /root

COPY package.json ./
RUN npm install

COPY src ./src

EXPOSE 8011
CMD [ "node", "src/server.js" ]
