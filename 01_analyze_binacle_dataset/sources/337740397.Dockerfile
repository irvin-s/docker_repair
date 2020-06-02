FROM node:alpine

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app


ONBUILD COPY . /usr/src/app/
ONBUILD RUN npm install

# Build app
ONBUILD RUN npm run build

ENV HOST 0.0.0.0
EXPOSE 3000

# start command
CMD [ "npm", "start" ]
