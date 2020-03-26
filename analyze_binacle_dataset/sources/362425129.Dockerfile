# 9fs file server

FROM debian:sid
MAINTAINER jordi collell <j@tmpo.io>

RUN apt-get update && apt-get install -y \
    diod


VOLUME /data

CMD [ "diod", "--export=/data", "-n", "-f", "-l", "0.0.0.0:5640" ]
EXPOSE 5640
