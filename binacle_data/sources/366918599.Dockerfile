FROM bcoe/newww:1.0.6

RUN apk update
RUN apk add bash
COPY ./files/.env /etc/npme/node_modules/newww/.env
COPY ./files/start.sh /etc/npme/start.sh
