FROM node:latest
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
EXPOSE 3000
VOLUME ["/usr/src/app", "/usr/src/app/node_modules"]
CMD ["npm", "start"]