FROM ctlc/haproxy
MAINTAINER Lucas Carlson <lucas@rufy.com>

# Let's get serf
RUN apt-get install -qy unzip
ADD https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip serf.zip
RUN unzip serf.zip
RUN mv serf /usr/bin/

ADD serf-member-join.sh /serf-member-join.sh
ADD serf-member-leave.sh /serf-member-leave.sh

ADD /start-serf.sh /start-serf.sh
ADD /serf-join.sh /serf-join.sh
ADD /supervisord-serf.conf /etc/supervisor/conf.d/supervisord-serf.conf
RUN chmod 755 /*.sh
RUN rm *.zip

EXPOSE 80
CMD ["/run.sh"]
