FROM node:8.11.3

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 8080
CMD [ "npm", "run", "serve" ]