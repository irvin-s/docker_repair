FROM node:7.4.0

ADD package.json .
RUN npm install

ADD index.js .

CMD ["npm", "start"]
