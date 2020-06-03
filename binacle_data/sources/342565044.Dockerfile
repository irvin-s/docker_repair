FROM node:8.7.0-alpine

RUN apk add --no-cache python gcc g++ make git \
# we use nodemon to auto-restart the server when serverside code changes
    && npm install nodemon -g

RUN mkdir /log

# install ui dependencies
WORKDIR /app/ui
COPY package.json /app/ui/package.json
COPY package-lock.json /app/ui/package-lock.json
RUN npm install

# add ui source code
COPY src/ /app/ui/src/

# start development ui server
CMD ["npm", "run", "start:dev"]
