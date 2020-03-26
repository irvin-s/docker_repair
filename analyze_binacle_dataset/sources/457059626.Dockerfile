FROM node:boron-alpine
RUN mkdir -p /code
WORKDIR /code
COPY package.json .
RUN yarn
ADD . /code
RUN yarn build
CMD [ "yarn", "start:production" ]
EXPOSE 3000
