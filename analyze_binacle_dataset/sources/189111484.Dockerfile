FROM rounds/10m-graphite-carbon
MAINTAINER Ofir Petrushka

COPY relay-rules.conf /etc/carbon/relay-rules.conf

CMD /usr/bin/carbon-relay --nodaemon --config=/etc/carbon/carbon.conf --pidfile=/var/run/carbon-relay.pid --logdir=/var/log/carbon/ start
