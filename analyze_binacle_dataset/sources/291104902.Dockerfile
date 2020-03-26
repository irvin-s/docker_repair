FROM mhart/alpine-node:latest

WORKDIR /usr/api
COPY package.json .
COPY package-lock.json .
COPY tsconfig.json .

RUN npm install

COPY src .

RUN npm run build

EXPOSE 9090

CMD ["npm", "run", "start-server"]
