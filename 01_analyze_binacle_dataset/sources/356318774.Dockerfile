FROM momonga/emacs-daemon
MAINTAINER supermomonga

COPY ./data/ /root/data/
VOLUME /root/data

EXPOSE 80
