FROM phusion/baseimage:0.9.17

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
        samba \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add startup scripts
RUN mkdir -p /etc/my_init.d
COPY samba_setup.sh /etc/my_init.d/

# Add services
RUN mkdir /etc/service/samba
COPY samba_run.sh /etc/service/samba/run
COPY samba_finish.sh /etc/service/samba/finish

VOLUME ["/var/lib/samba"]

CMD ["/sbin/my_init"]
