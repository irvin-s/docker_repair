FROM segator/docker-plex:latest
MAINTAINER Isaac Aymerich <isaac.aymerich@gmail.com>

COPY plex-init /sbin/plex-init
RUN chmod +x /sbin/plex-init && usermod -s /bin/bash abc \
    && apt-get update && apt-get -y install python-pip \
    && pip install requests --upgrade
COPY plex_wrapper_transcoder /defaults/
COPY init/ /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*

VOLUME /usr/lib/plexmediaserver

CMD ["/sbin/plex-init"]
