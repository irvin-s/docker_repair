FROM node

# Build app
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN npm install --production

EXPOSE 3000

CMD [ "node","bin/www"]
