FROM node:10
WORKDIR /usr/src/app

COPY package.json package-lock.json ./
RUN npm install

COPY . ./
RUN npm run build

CMD ["npm", "start"]

