FROM node

COPY ./source/node /node
WORKDIR /node

RUN npm install

CMD npm start