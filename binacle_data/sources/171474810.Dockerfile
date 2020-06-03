FROM ubuntu:15.10

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_GB en_GB.UTF-8 && dpkg-reconfigure locales

# Prerequisites
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && \
    apt-get update && apt-get install -y \
    rsyslog \
    amavisd-new \
    spamassassin \
    libnet-dns-perl \
    libmail-spf-perl \
    pyzor \
    razor \
    jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up razor and pyzor
RUN su - amavis -s /bin/bash && razor-admin -create && razor-admin -register && pyzor discover

COPY ./config/conf.d /etc/amavis/conf.d
COPY ./config/rsyslog.conf /etc/rsyslog.conf

# Nice place for your settings
VOLUME ["/mail_settings"]

# Copy boot scripts
COPY boot /
COPY boot.d /boot.d
RUN chmod 755 /boot /boot.d/*

ENV AMAVIS=true

EXPOSE 10024
CMD ./boot; amavisd-new; rsyslogd -n
