FROM node:7

ENV app /app
RUN mkdir $app
WORKDIR $app

ONBUILD COPY .. $app

ONBUILD RUN npm install

CMD [ "npm", "start" ]