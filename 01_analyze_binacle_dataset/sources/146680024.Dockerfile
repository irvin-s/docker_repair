# Create a local-use Debile slave.
#
# VERSION   0.1
FROM        paultag/debile-slave-ursae
MAINTAINER  Paul R. Tagliamonte <paultag@debian.org>

USER root
ENV HOME /var/lib/debile/debile-unpriv
ADD config.tar.gz /tmp/config/
RUN cd /tmp/config; tar -zcvf ../config.tar.gz *

RUN /usr/share/debile-slave/debile-slave-import-conf /tmp/config.tar.gz
USER Debian-debile-unpriv

RUN /usr/share/debile-slave/debile-slave-import-gpg /tmp/config.tar.gz

RUN sbuild-update --keygen
CMD ["/usr/bin/debile-slave"]
