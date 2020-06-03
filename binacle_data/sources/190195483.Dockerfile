FROM jpetazzo/squid-in-a-can:latest
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>

RUN apt-get -q update && apt-get -yq install rsync

VOLUME ["/var/cache/squid3","/host-datadir","/etc/cron.d","/tmp/registry-dev","/usr/share/nginx/html"]

ADD backup.sh /backup.sh
ADD entrypoint.sh /entrypoint.sh

CMD ["/bin/sh","-x","/entrypoint.sh"]
