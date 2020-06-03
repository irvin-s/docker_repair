FROM debian:stretch
ARG VERSION=latest
MAINTAINER Tristan Teufel <info@teufel-it.de>

RUN apt-get update
RUN apt-get install sqlite3 libcrypto++6 libcurl3 libfuse2 wget -y

RUN if [ "${VERSION}" = "latest" ] ; then \
    LATEST=$(wget https://hndl.urbackup.org/Server/latest/debian/stretch/ -q -O - | tr '\n' '\r' | sed -r 's/.*server_([0-9\.]+)_amd64\.deb.*/\1/') && \
    wget -O /root/urbackup.deb https://hndl.urbackup.org/Server/latest/debian/stretch/urbackup-server_${LATEST}_amd64.deb; \
    else wget -O /root/urbackup.deb https://www.urbackup.org/downloads/Server/${VERSION}/debian/stretch/urbackup-server_${VERSION}_amd64.deb; \
    fi

RUN DEBIAN_FRONTEND=noninteractive dpkg -i /root/urbackup.deb  || true

ADD backupfolder /etc/urbackup/backupfolder
RUN chmod +x /etc/urbackup/backupfolder

EXPOSE 55413
EXPOSE 55414
EXPOSE 55415
EXPOSE 35623

VOLUME [ "/var/urbackup", "/var/log", "/backup"]
ENTRYPOINT ["/usr/bin/urbackupsrv"]
CMD ["run"]
