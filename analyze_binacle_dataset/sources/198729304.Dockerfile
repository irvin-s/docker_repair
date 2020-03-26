FROM phusion/passenger-customizable:0.9.18
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
ENV DEBIAN_FRONTEND noninteractive
ENV TERM screen

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Build system and git.
RUN /pd_build/utilities.sh

# Add node 4.x.
RUN echo "\
deb https://deb.nodesource.com/node_4.x trusty main\n\
deb-src https://deb.nodesource.com/node_4.x trusty main\n\
" > /etc/apt/sources.list.d/nodesource.list

# And its key.
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

# Add acmetool https://github.com/hlandau/acme to supprt let's encrypt.
RUN echo "\
deb http://ppa.launchpad.net/hlandau/rhea/ubuntu trusty main\n\
deb-src http://ppa.launchpad.net/hlandau/rhea/ubuntu trusty main\n\
" > /etc/apt/sources.list.d/acmetool.list

# And its key.
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9862409EF124EC763B84972FF5AC9651EDB58DFA

# Install certificate for OCSP stapling.
ADD certs/lets-encrypt-x1-cross-signed.pem /etc/ssl/certs/lets-encrypt-x1-cross-signed.pem

# Install the default cronjob (to auto-renew certificates).
RUN echo "\
SHELL=/bin/sh\n\
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin\n\
MAILTO=root\n\
15 4 * * * root /usr/bin/acmetool --batch reconcile\n\
" > /etc/cron.d/acmetool

# Install the latest available package and clean up APT when done.
ENV APTLIST="nodejs acmetool"

RUN apt-get update -q && \
    apt-get install -qy $APTLIST && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable nginx as a reverse-proxy.
RUN rm -f /etc/service/nginx/down

# Disable default config.
RUN rm /etc/nginx/sites-enabled/default

# Add app config.
ADD sites-enabled/webapp.conf /etc/nginx/sites-enabled/webapp.conf

# App root.
RUN mkdir /home/app/webapp

# Add service files.
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/my_init.d/*.sh

EXPOSE 80 443
