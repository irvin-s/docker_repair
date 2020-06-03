FROM alpine:latest
MAINTAINER playniuniu@gmail.com

ENV URL https://www.google.com

RUN apk --no-cache --update add firefox-esr dbus-x11 ttf-ubuntu-font-family \
    && adduser -S normaluser \
    && echo "normaluser:normaluser" | chpasswd

USER normaluser

CMD firefox --new-instance ${URL}

