FROM  ubuntu:trusty
MAINTAINER John Dilts <john.dilts@enstratius.com>

RUN apt-get update && apt-get install -y curl wget \
                          git-core supervisor apache2 apache2-mpm-worker

RUN curl -O -L http://grafanarel.s3.amazonaws.com/grafana-1.9.1.tar.gz
RUN tar xf grafana-1.9.1.tar.gz
RUN cp -R grafana-1.9.1 /usr/share/grafana
ADD grafana-config.js /usr/share/grafana/config.js

ADD https://raw.githubusercontent.com/jbrien/sensu-docker/compose/support/install-sensu.sh /tmp/
RUN chmod +x /tmp/install-sensu.sh
RUN /tmp/install-sensu.sh

ADD grafana-run.sh /tmp/

RUN rm -f /etc/apache2/sites-enabled/000-default.conf
ADD apache2-grafana.conf /etc/apache2/sites-enabled/grafana.conf

ADD supervisor.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME /usr/share/grafana
EXPOSE 80

CMD ["/tmp/grafana-run.sh"]
