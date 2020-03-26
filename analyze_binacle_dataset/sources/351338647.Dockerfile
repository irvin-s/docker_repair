# Riak
#
# VERSION       0.0.1

# Use the Debian base image
FROM debian:stable
MAINTAINER Attila Bardi attila.bardi@gmail.com

RUN apt-get update && apt-get -y dist-upgrade && apt-get -y install squid3 supervisor

RUN /usr/sbin/squid3 -z -F

RUN mkdir -p /var/log/supervisor

# ADD squid.conf /etc/squid3/squid.conf
# ADD supervisord.conf /etc/supervisord.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY squid.conf /etc/squid3/squid.conf

# Expose Squid3 port
EXPOSE 3128

CMD ["/usr/bin/supervisord"]

# ENTRYPOINT ["/usr/bin/supervisord", "-n"]