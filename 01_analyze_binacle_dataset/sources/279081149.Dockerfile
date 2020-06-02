## Please use Docker >= 17.06

FROM node:boron as builder

WORKDIR /app
ADD . /app

RUN yarn install
RUN yarn build

# Runtime
FROM node:boron-alpine

RUN apk add --no-cache \
		openssl curl

EXPOSE 8080

WORKDIR /app

COPY --from=builder /app/dist/ /app/dist

ADD package.json /app
ADD yarn.lock /app
ADD server.js /app
ADD server/ /app/server
ADD config/ /app/config

RUN yarn install --production

HEALTHCHECK CMD curl -f http://localhost:8080/api/status

CMD node server.js
