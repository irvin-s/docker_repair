# This is just a simple docker file

FROM node:10

RUN mkdir /opt/megabot
COPY . /opt/megabot
WORKDIR /opt/megabot
RUN npm i --production
CMD ["node", "index.js"]
