FROM node:latest

EXPOSE 8080
WORKDIR /bindmount
COPY package-lock.json package.json ./
RUN npm install --no-progress --ignore-optional

CMD npm run start:dev