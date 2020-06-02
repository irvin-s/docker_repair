FROM oddlid/debian-base:stretch
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

RUN apt-get -y --no-install-recommends install kpcli \
		&& \
		rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["tini", "-g", "--", "/entrypoint.sh"]

