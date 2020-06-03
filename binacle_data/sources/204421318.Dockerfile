FROM rawmind/alpine-base:3.8-0
MAINTAINER Raul Sanchez <rawmind@gmail.com>

ADD root /
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
