FROM oddlid/lobsterperl
MAINTAINER Odd Eivind Ebbesen <oddebb@gmail.com>

RUN apt-get update -qq \
		&& \
		apt-get install -yq --no-install-recommends ddclient \
		&& \
		apt-get clean autoclean \
		&& \
		apt-get autoremove -y \
		&& \
		rm -rf /var/lib/apt/lists/* \
		&& \
		rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY ddclient /etc/default/ddclient
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME ["/var/cache/ddclient", "/var/run"]

ENTRYPOINT ["tini", "-g", "--", "entrypoint.sh"]
CMD ["ddclient"]
