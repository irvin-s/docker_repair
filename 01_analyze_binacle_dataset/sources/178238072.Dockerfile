# Another step towards running my regular server apps in Docker

FROM oddlid/debian-base:jessie
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>


ENV DEBIAN_FRONTEND noninteractive
RUN ln -fs /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
RUN apt-get -qq update \
		&& \
		apt-get install -y --only-upgrade bash \
		&& \
		apt-get install -y --no-install-recommends quassel-core supervisor \
		&& \
		apt-get -y clean autoclean \
		&& \
		apt-get autoremove -y \
		&& \
		rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY supervisord.conf /etc/supervisor/conf.d/
COPY run.sh /

VOLUME /var/lib/quassel
VOLUME /var/run
EXPOSE 4242

ENTRYPOINT ["/sbin/tini", "-g", "--", "/run.sh"]
