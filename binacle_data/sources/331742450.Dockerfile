FROM node:latest

WORKDIR /home/app

COPY package*.json ./
RUN npm i

RUN npm i -g sequelize-cli

COPY . .

EXPOSE $PORT

CMD ["sh", "-c", "sequelize db:migrate && npm start"]
