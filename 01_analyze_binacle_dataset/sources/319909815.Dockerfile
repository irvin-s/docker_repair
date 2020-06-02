FROM node:alpine

WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm ci
COPY . .

EXPOSE 80
CMD ["npm", "start"]
