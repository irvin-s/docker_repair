FROM node:8.9.3-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY . .
CMD ["npm", "run", "start:prod:server"]
EXPOSE 3000
