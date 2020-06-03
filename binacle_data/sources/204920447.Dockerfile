FROM node:11
WORKDIR /home/app/server
COPY package*.json ./
RUN npm i
COPY . .
CMD ["node", "index.js"]
