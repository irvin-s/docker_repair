FROM ubuntu:14.04 AS compile
MAINTAINER Stian Soiland-Reyes <orcid.org/0000-0001-9842-9718>

# openjdk 6 hard-coded to resolve
# ambiguity in build dependency
# https://github.com/openlink/virtuoso-opensource/issues/342
# FIXME: Is openjdk-6-jdk still needed?
ENV BUILD_DEPS openjdk-6-jdk unzip wget net-tools build-essential

ENV URL https://github.com/openlink/virtuoso-opensource/releases/download/v7.2.4.2/virtuoso-opensource-7.2.4.2.tar.gz
#ENV URL https://github.com/openlink/virtuoso-opensource/archive/stable/7.tar.gz


# Build virtuoso opensource debian package from github
RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise-backports main restricted universe multiverse" >> /etc/apt/sources.list
##RUN export DEBIAN_FRONTEND=noninteractive && \
##    apt-get update && \
##    apt-get install -y $BUILD_DEPS && \
##    cd /tmp && \
##    wget --no-check-certificate --quiet $URL \
##       -O /tmp/virtuoso-opensource.tar.gz && \
##    tar xf /tmp/virtuoso-opensource.tar.gz && \
##    deps=$(dpkg-checkbuilddeps 2>&1 | sed 's/.*: //' | sed 's/([^)]*)//g') && \
##    apt-get install -y $deps && \
##    dpkg-buildpackage -us -uc && \
##    apt-get remove -y --purge $BUILD_DEPS $deps && \
##    apt-get autoremove --purge -y && \
##    cd /tmp && \
##    dpkg -i virtuoso-opensource*deb virtuoso-server*.deb virtuoso-minimal_*.deb virtuoso-server*.deb  libvirtodbc*.deb || apt-get install -f -y && \
##    apt-get autoclean && \
##    rm -rf /var/lib/apt/lists/* && \
##    mv /tmp/*deb /var/cache/apt/archives/ && \
##    rm -rf /tmp/*

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y $BUILD_DEPS
WORKDIR /tmp
RUN wget --no-check-certificate --quiet $URL -O /tmp/virtuoso-opensource.tar.gz
RUN tar xf /tmp/virtuoso-opensource.tar.gz 
RUN ln -s virtuoso-opensource-* virtuoso-opensource
WORKDIR /tmp/virtuoso-opensource
RUN dpkg-checkbuilddeps 2>&1 | sed 's/.*: //' | sed 's/([^)]*)//g' | xargs apt-get install -y $deps
RUN dpkg-buildpackage -us -uc
WORKDIR /tmp
RUN mkdir /dist && cp virtuoso-opensource*deb virtuoso-server*.deb virtuoso-minimal_*.deb libvirtodbc*.deb /dist


# Second stage, install without build dependencies

FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive
# Copy from previous stage
COPY --from=compile /dist /dist
RUN apt-get update
WORKDIR /dist
# dpkg will fail as dependencies are missing, top-up with apt
RUN dpkg -i *.deb || apt-get install -f -y

RUN ln -s /usr/bin/isql-vt /usr/local/bin/isql


# Enable mountable /virtuoso for data storage, which
# we'll symlink the standard db folder to point to
RUN mkdir /virtuoso
RUN rm -rf /var/lib/virtuoso-opensource-7/db
RUN ln -s /virtuoso /var/lib/virtuoso-opensource-7/db
VOLUME /virtuoso

# /staging for loading data
RUN mkdir /staging ; sed -i '/DirsAllowed/ s:$:,/staging:' /etc/virtuoso-opensource-7/virtuoso.ini
VOLUME /staging

COPY staging.sh /usr/local/bin/
COPY docker-entrypoint.sh /
RUN chmod 755 /usr/local/bin/staging.sh /docker-entrypoint.sh


# Virtuoso ports
EXPOSE 8890
EXPOSE 1111
WORKDIR /virtuoso
# Modify config-file on start-up to reflect memory available
ENTRYPOINT ["/docker-entrypoint.sh"]
# Run virtuoso in the foreground
CMD ["/usr/bin/virtuoso-t", "+wait", "+foreground", "+configfile", "/etc/virtuoso-opensource-7/virtuoso.ini"]

