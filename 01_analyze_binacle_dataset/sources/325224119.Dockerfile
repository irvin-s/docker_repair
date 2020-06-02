FROM node:8.11.4-alpine
WORKDIR app
COPY . /app
RUN npm install
ENTRYPOINT ["npm", "start"]