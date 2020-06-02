FROM redis:latest

MAINTAINER yesterday679 <yesterday679@gmail.com>

EXPOSE 6379

CMD [ "redis-server" ]
