FROM phusion/baseimage:0.9.18
MAINTAINER needo <needo@superhero.org>
#Based on the work of Eric Schultz <eric@startuperic.com>
#Thanks to Tim Haak <tim@haak.co.uk>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# chfn workaround - Known issue within Dockers
RUN ln -s -f /bin/true /usr/bin/chfn

# Install Plex
RUN apt-get -q update
RUN apt-get install -qy gdebi-core wget
ADD installplex.sh /
RUN bash /installplex.sh

# Fix a Debianism of plex's uid being 101
RUN usermod -u 999 plex
RUN usermod -g 100 plex

VOLUME /config
VOLUME /data

EXPOSE 32400

# Define /config in the configuration file not using environment variables
ADD plexmediaserver /etc/default/plexmediaserver

# Add firstrun.sh to execute during container startup
RUN mkdir -p /etc/my_init.d
ADD firstrun.sh /etc/my_init.d/firstrun.sh
RUN chmod +x /etc/my_init.d/firstrun.sh

# Add Plex to runit
RUN mkdir /etc/service/plex
ADD plex.sh /etc/service/plex/run
RUN chmod +x /etc/service/plex/run
