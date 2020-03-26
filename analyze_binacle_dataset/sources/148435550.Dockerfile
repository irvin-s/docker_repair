FROM debian:latest

# Install and configure exim:
RUN apt-get update && apt-get install -y \
    exim4-daemon-light \
 && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN sed -ri "s/^(dc_eximconfig_configtype)=.*/\1='internet'/" /etc/exim4/update-exim4.conf.conf
RUN sed -ri "s/^(dc_local_interfaces)=.*/\1=''/" /etc/exim4/update-exim4.conf.conf
RUN sed -ri "s/^(dc_relay_nets)=.*/\1='*'/" /etc/exim4/update-exim4.conf.conf
RUN update-exim4.conf

# The volume that will contain the mail queue:
VOLUME /var/spool/exim4

STOPSIGNAL SIGKILL

CMD ["exim", "-bd", "-q15m", "-v"]

EXPOSE 25
