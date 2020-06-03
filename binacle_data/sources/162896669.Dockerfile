FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/root \
    GUAC_VERSION=0.9.8 \
    GUAC_JDBC_VERSION=0.9.8 \
    LC_ALL=en_US.UTF-8

RUN apt-mark hold initscripts udev plymouth mountall && \
    dpkg-divert --local --rename --add /sbin/initctl && \
    ln -sf /bin/true /sbin/initctl

RUN sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list

RUN apt-get update && \
    apt-get upgrade -y --force-yes

RUN apt-get install -y --force-yes \
    # main
    supervisor lxde-core lxde-icon-theme x11vnc \
    xvfb openbox wget firefox htop lxterminal postgresql postgresql-client-common \
    # guac
    tomcat7 build-essential make libcairo2-dev libjpeg-dev libpng-dev \
    libossp-uuid-dev libpulse-dev libvorbis-dev libvncserver-dev
    #&& apt-get autoclean \
    #&& apt-get autoremove \
    #&& rm -rf /var/lib/apt/lists/*

RUN apt-get install -y --force-yes curl

ADD startup.sh /
ADD supervisord.conf /

COPY guacamole-docker/bin /opt/guacamole/bin/
COPY guacd-docker/bin /opt/guacd/bin/
RUN \
    /opt/guacamole/bin/download-guacamole.sh "$GUAC_VERSION" /usr/local/tomcat/webapps && \
    /opt/guacamole/bin/download-jdbc-auth.sh "$GUAC_JDBC_VERSION" /opt/guacamole
RUN /opt/guacd/bin/download-guacd.sh "$GUAC_VERSION"

EXPOSE 8080
WORKDIR /
CMD ["/startup.sh"]
