FROM node:6.9.5

WORKDIR /app

COPY ./ /app/

RUN cd /app \
    && npm install
