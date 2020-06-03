# Create a local-use Debile slave.
#
# VERSION   0.1
FROM        paultag/debile-slave-base
MAINTAINER  Paul R. Tagliamonte <paultag@debian.org>

ADD ursae.json /usr/share/dput-ng/profiles/
ADD slave.yaml /etc/debile/

USER root
RUN chown -R Debian-debile-unpriv:Debian-debile-unpriv /etc/debile/*
# Hack for our entrypoint later.

USER Debian-debile-unpriv
