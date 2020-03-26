FROM node:8
RUN mkdir /mariner
WORKDIR /mariner
ADD app.js /mariner/app.js
CMD node app.js
