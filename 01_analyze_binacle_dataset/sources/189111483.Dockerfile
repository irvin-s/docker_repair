FROM rounds/10m-graphite-carbon
MAINTAINER Ofir Petrushka

CMD /usr/bin/carbon-cache --nodaemon --config=/etc/carbon/carbon.conf --pidfile=/var/run/carbon-cache.pid --logdir=/var/log/carbon/ start
