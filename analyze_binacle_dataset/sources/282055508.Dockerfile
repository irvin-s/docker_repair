FROM node:8-alpine

EXPOSE 8080

WORKDIR /usr/src/app

COPY package.json .* /usr/src/app/
RUN npm install

COPY utils/ /usr/src/app/utils
COPY build/ /usr/src/app/build

CMD ["sh", "-c", "npm run start-prod" ]