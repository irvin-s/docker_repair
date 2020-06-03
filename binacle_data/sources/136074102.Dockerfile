FROM lyapi-baseimage:latest
MAINTAINER Lien Chiang <xsoameix@gmail.com>

ADD app.ls app/app.ls
ADD lib app/lib

EXPOSE 3000

CMD lsc app/app.ls \
        --host 0.0.0.0 \
        --port 3000 \
        --db tcp://ly:ly@$PG_PORT_5432_TCP_ADDR:$PG_PORT_5432_TCP_PORT/ly
