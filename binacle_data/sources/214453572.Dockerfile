FROM ubuntu:trusty
MAINTAINER John Dilts <john.dilts@enstratius.com>

RUN apt-get update && apt-get install -y curl wget openssl redis-server supervisor

ADD https://raw.githubusercontent.com/jbrien/sensu-docker/compose/support/install-sensu.sh /tmp/
RUN chmod +x /tmp/install-sensu.sh
RUN /tmp/install-sensu.sh

ADD redis-run.sh /tmp/
ADD supervisor.conf /etc/supervisor/conf.d/sensu.conf

CMD /tmp/redis-run.sh
