FROM resin/rpi-raspbian:wheezy

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 7638D0442B90D010

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y -q \
    ca-certificates \
    nginx \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log

RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

