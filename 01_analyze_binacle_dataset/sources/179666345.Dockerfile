FROM node:8

RUN curl -o- -L https://yarnpkg.com/install.sh | bash

WORKDIR /usr/src/app
COPY package*.json yarn.lock ./

RUN yarn global add nodemon

RUN yarn

COPY . .

EXPOSE 4000

CMD ["yarn", "dev"]
