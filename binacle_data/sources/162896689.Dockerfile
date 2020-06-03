# InterProScan
# VERSION 0.1
# Tracking 5.7-48.0

FROM debian:wheezy

# make sure the package repository is up to date
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update

# Install InterProScan
RUN DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install openjdk-7-jre-headless wget
RUN wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.7-48.0/interproscan-5.7-48.0-64-bit.tar.gz -O /interproscan-5.7-48.0-64-bit.tar.gz && \
    wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.7-48.0/interproscan-5.7-48.0-64-bit.tar.gz.md5 -O /interproscan-5.7-48.0-64-bit.tar.gz.md5 && \
    md5sum -c /interproscan-5.7-48.0-64-bit.tar.gz.md5 && \
    tar -pxvzf /interproscan-5.7-48.0-64-bit.tar.gz && \
    rm -rf /interproscan-5.7-48.0/data/ && \
    rm -f /interproscan-5.7-48.0-64-bit.tar.gz /interproscan-5.7-48.0-64-bit.tar.gz.md5;
# This is all done in a single step to ensure final image size is small

VOLUME ["/interproscan-5.7-48.0/data/", "/interproscan-5.7-48.0/bin/signalp/4.0/", "/interproscan-5.7-48.0/bin/tmhmm/2.0/", "/interproscan-5.7-48.0/bin/phobius/1.01/"]
WORKDIR /interproscan-5.7-48.0/
COPY ./interproscan.properties /interproscan-5.7-48.0/interproscan.properties
COPY ./interproscan.sh /interproscan-5.7-48.0/interproscan.sh
ENV DOCKER_JAVA_ARGS -XX:+UseParallelGC -XX:ParallelGCThreads=2 -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -Xms128M -Xmx2048M
