FROM ubuntu:15.10

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      avahi-daemon \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD avahi-daemon.conf /etc/avahi/avahi-daemon.conf

ADD start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

ENTRYPOINT /usr/local/bin/start.sh
