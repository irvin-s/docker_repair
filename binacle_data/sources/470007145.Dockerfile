FROM node

WORKDIR /src

COPY package.json .
RUN npm i
RUN npm install forever -g

COPY . .

EXPOSE 8080

CMD ["forever", "./server/server.js"]
