FROM ubuntu:trusty
MAINTAINER John Dilts <john.dilts@enstratius.com>

RUN apt-get update && apt-get install -y curl wget openssl supervisor

RUN useradd -d /home/sensu -m -s /bin/bash sensu
RUN echo sensu:sensu | chpasswd

ADD https://raw.githubusercontent.com/jbrien/sensu-docker/compose/support/install-sensu.sh /tmp/
RUN chmod +x /tmp/install-sensu.sh
RUN /tmp/install-sensu.sh

ADD install-uchiwa.sh /tmp/
RUN /tmp/install-uchiwa.sh

ADD supervisor.conf /etc/supervisor/conf.d/sensu.conf
ADD sensu-run.sh /tmp/sensu-run.sh

VOLUME /var/log/sensu
VOLUME /etc/sensu/conf.d

EXPOSE 4567
EXPOSE 5671
EXPOSE 6379

CMD ["/tmp/sensu-run.sh"]
