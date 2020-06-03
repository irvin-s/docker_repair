FROM node:8.5.0

RUN mkdir /app
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
ENV MONGO_HOST=mongodb://mongo:27017/Teste_local
EXPOSE 3001
