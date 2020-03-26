FROM oddlid/debian-base:jessie
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

ENV OPENFIRE_VERSION 3.9.3

RUN apt-get update -qq \
		&& \
		apt-get install -y --no-install-recommends \
		openjdk-7-jre \
		&& \
		curl -L "http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}_all.deb" \
		-o /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
		&& \
		dpkg -i /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
		&& \
		rm -f /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
		&&  \
		apt-get clean autoclean \
		&& \
		apt-get autoremove -y \
		&& \
		rm -rf /var/lib/{apt,dpkg,cache,log}/

VOLUME ["/data"]
EXPOSE 3478 3479 5222 5223 5229 7070 7443 7777 9090 9091

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["tini", "-g", "--", "entrypoint.sh"]
