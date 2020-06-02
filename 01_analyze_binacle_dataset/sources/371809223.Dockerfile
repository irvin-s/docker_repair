FROM ubuntu:16.04
MAINTAINER David Elner <david@davidelner.com>

# Install core utilities
RUN apt-get update -q && \
    apt-get install -qy vim screen lsof tcpdump iptraf --no-install-recommends &&\

    # Then cleanup
    apt-get clean && \
    cd /var/lib/apt/lists && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log
