FROM node:9-alpine

WORKDIR /src
COPY package.json .
RUN yarn install --ignore-engines

EXPOSE 3000
CMD ["yarn", "dev"]