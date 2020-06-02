FROM node:8-alpine

RUN apk add --no-cache curl
RUN adduser -D rabblerouser

WORKDIR /app

RUN chown -R rabblerouser /app
USER rabblerouser

EXPOSE 3000
