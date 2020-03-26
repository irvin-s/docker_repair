
# take inspiration from:
# https://hub.docker.com/r/greyarch/rethinkdb/~/dockerfile/

FROM alpine:edge
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

# RUN echo http://nl.alpinelinux.org/alpine/edge/testing \
#     >> /etc/apk/repositories; \
#     apk add --update --no-cache rethinkdb
RUN apk update && apk add --update --no-cache rethinkdb

VOLUME /data
WORKDIR /data

EXPOSE 28015 29015 8080
ENTRYPOINT ["rethinkdb"]
CMD ["--bind", "all"]
