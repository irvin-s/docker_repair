FROM node:slim

RUN npm install -g laravel-echo-server --unsafe-perm

WORKDIR /app

EXPOSE 6001

ENTRYPOINT ["node"]

CMD ["/usr/local/bin/laravel-echo-server", "start"]