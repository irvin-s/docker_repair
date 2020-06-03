FROM redis:latest

MAINTAINER Ahmad Shah Hafizan Hamidin <ahmadshahhafizan@gmail.com>

VOLUME /data

EXPOSE 6379

CMD ["redis-server"]