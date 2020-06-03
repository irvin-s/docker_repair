FROM node:carbon
WORKDIR /usr/src/api
COPY package.json ./
COPY yarn.lock ./
RUN yarn
COPY . .
EXPOSE 80 
CMD ["yarn", "start"]
