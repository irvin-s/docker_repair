FROM mhart/alpine-node:6

RUN mkdir -p /app
WORKDIR /app
COPY package.json .

RUN apk add --update alpine-sdk python && \
    npm install -g gulp-cli http-server && \
    npm install && \
    apk del --purge alpine-sdk python

COPY . .
RUN gulp build

CMD http-server /app/dist
