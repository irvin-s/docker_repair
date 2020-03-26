FROM node:11

LABEL maintainer="http://www.hasadna.org.il/"

ENV APP_DIR /home/app/blop

WORKDIR $APP_DIR

COPY package*.json ./
RUN npm i

COPY . $APP_DIR
RUN npm run build

CMD ["npm", "start"]
