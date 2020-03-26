FROM node:latest
ADD . .
RUN npm install
CMD npm start