FROM kazu69/node:6.3.0

RUN apk add --update mysql mysql-client && \
    rm -f /var/cache/apk/*
RUN mkdir -p /var/www
WORKDIR /var/www
ADD ./package.json package.json
ADD ./app app
ADD ./config config
ADD ./migrations migrations
ADD ./seeders seeders

RUN npm i

EXPOSE 3000

CMD ["node", "app/index.js"]
