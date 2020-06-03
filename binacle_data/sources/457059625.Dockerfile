FROM node:boron-alpine
RUN mkdir -p /code
WORKDIR /code
COPY package.json .
RUN yarn
ADD . /code
CMD [ "yarn", "start:dev" ]
EXPOSE 3001
