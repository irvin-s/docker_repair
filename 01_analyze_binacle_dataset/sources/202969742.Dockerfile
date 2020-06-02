FROM debian:jessie
MAINTAINER L. Mangani <lorenzo.mangani@gmail.com>
# v.5.05

# Default baseimage settings
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Update and upgrade apt
RUN apt-get update -qq && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 049AD65B \
&& echo "deb http://apt.opensips.org jessie 2.2-releases" >>/etc/apt/sources.list \
&& apt-get update -qq && apt-get install -f -yqq rsyslog opensips opensips-geoip-module opensips-json-module opensips-mysql-module opensips-regex-module opensips-restclient-module geoip-database geoip-database-extra && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/opensips
COPY opensips.cfg /etc/opensips/opensips.cfg
RUN chmod 775 /etc/opensips/opensips.cfg

RUN ln -s /usr/lib64 /usr/lib/x86_64-linux-gnu/

# GeoIP (http://dev.maxmind.com/geoip/legacy/geolite/)
# RUN cd /usr/share/GeoIP && curl http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz > GeoLiteCity.dat.gz && gunzip GeoLiteCity.dat.gz

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh

# HEP
EXPOSE 5062
EXPOSE 9060

ENTRYPOINT ["/run.sh"]
