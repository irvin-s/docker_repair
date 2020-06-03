FROM busybox
MAINTAINER Bob Pace <bob.pace@gmail.com>

RUN adduser --disabled-password --gecos "" devuser \
    && mkdir -p /home/devuser/data \
    && chown -R devuser /home/devuser/data

VOLUME /home/devuser/data

CMD ["true"]
