FROM ubuntu:latest
MAINTAINER playniuniu@gmail.com

ENV DEBIAN_FRONTEND nointeractive
ENV URL https://www.google.com

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends firefox dbus-x11 ttf-wqy-microhei \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
    && useradd -m normaluser

USER normaluser

CMD firefox --new-instance ${URL}
