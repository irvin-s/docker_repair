FROM node:9.2.0-alpine

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

USER nobody

CMD ["npm", "start"]