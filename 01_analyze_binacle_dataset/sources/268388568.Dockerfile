FROM node:latest

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json ./
COPY yarn.lock ./
COPY . .

RUN yarn 

EXPOSE 3000
EXPOSE 35729

CMD ["yarn", "start"]