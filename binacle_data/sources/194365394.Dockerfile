FROM darron/caddy

RUN mkdir /srv

ADD . /srv

WORKDIR /srv

EXPOSE 2015

CMD caddy
