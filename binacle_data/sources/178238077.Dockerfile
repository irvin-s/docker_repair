# See jenserat/seafile for more details

FROM oddlid/debian-base:jessie
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

RUN apt-get update -qq \
	&& \
	apt-get install -y --no-install-recommends \
	libpython2.7 \
	python2.7 \
	python-imaging \
	python-ldap \
	python-memcache \
	python-mysqldb \
	python-setuptools \
	python-simplejson \
	socat \
	sqlite3 \
	&& \
	ulimit -n 30000 \
	&& \
	apt-get clean autoclean \
	&& \
	apt-get autoremove -y \
	&& \
	rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY start_seafile.sh /usr/local/bin/
VOLUME ["/opt/seafile", "/var/log"]
EXPOSE 8000 8080 8082 10001 12001
CMD ["/usr/local/bin/start_seafile.sh"]
