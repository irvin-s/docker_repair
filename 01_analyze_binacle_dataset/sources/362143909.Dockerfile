FROM phusion/baseimage:0.9.17
MAINTAINER Joe Ruether

ENV DISPLAY :100

EXPOSE 9999

RUN `# Creating user / Adjusting user permissions`                                                                   && \
     (groupadd -g 1000 xpra || true)                                                                                 && \
     ((useradd -u 1000 -g 1000 -p xpra -m xpra) ||                                                                      \
      (usermod -u 1000 xpra && groupmod -g 1000 xpra))                                                               && \
                                                                                                                        \
    `# Updating Package List`                                                                                        && \
     DEBIAN_FRONTEND=noninteractive apt-get update                                                                   && \
                                                                                                                        \
    `# Installing packages`                                                                                          && \
     DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends wget                                     \
                                                                               ssl-cert                              && \
                                                                                                                        \
    `# Adding xpra repository`                                                                                       && \
     wget -O - http://winswitch.org/gpg.asc | apt-key add -                                                          && \
     echo 'deb http://winswitch.org/ trusty main' >> /etc/apt/sources.list.d/xpra.list                               && \
                                                                                                                        \
    `# Adding apt-cacher-ng proxy`                                                                                   && \
     echo 'Acquire::http { Proxy "http://172.17.42.1:3142"; };' > /etc/apt/apt.conf.d/01proxy                        && \
                                                                                                                        \
    `# Updating Package List`                                                                                        && \
     DEBIAN_FRONTEND=noninteractive apt-get update                                                                   && \
                                                                                                                        \
    `# Installing packages`                                                                                          && \
     DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xpra                                  && \
                                                                                                                        \
    `# Cleaning up after installation`                                                                               && \
     DEBIAN_FRONTEND=noninteractive apt-get clean                                                                    && \
     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*                                                                   && \
                                                                                                                        \
    `# Installing xpra daemon`                                                                                       && \
     mkdir -p /etc/service/xpra                                                                                      && \
     echo '#!/bin/sh' > /etc/service/xpra/run                                                                        && \
     echo "exec /sbin/setuser xpra xpra start $DISPLAY --bind-tcp=0.0.0.0:9999 --daemon=no" >> /etc/service/xpra/run && \
     chmod 755 /etc/service/xpra/run                                                                                

ENTRYPOINT ["/sbin/my_init"]
