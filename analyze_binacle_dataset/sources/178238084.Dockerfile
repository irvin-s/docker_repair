FROM dock0/arch
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

RUN pacman -S --noconfirm --needed sslh \
		&& \
		rm -rf /var/cache/pacman/pkg/*

ENV LISTEN_IP 0.0.0.0
ENV LISTEN_PORT 443
ENV SSH_HOST localhost
ENV SSH_PORT 22
ENV OPENVPN_HOST localhost
ENV OPENVPN_PORT 1194
ENV HTTPS_HOST localhost
ENV HTTPS_PORT 8443
#ENV TINI_VERSION 0.18.0
#ENV TINI_GPG_KEY 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7

#ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static /sbin/tini
#ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static.asc /tmp/tini-static.asc
#RUN gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7
#RUN gpg --batch --verify /tmp/tini-static.asc /sbin/tini
#RUN chmod 755 /sbin/tini

EXPOSE 443

ENTRYPOINT ["/dev/init", "-g", "--"]
CMD sslh -f -u root -p ${LISTEN_IP}:${LISTEN_PORT} --ssh ${SSH_HOST}:${SSH_PORT} --ssl ${HTTPS_HOST}:${HTTPS_PORT} --openvpn ${OPENVPN_HOST}:${OPENVPN_PORT}
