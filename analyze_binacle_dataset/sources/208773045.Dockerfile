FROM ubuntu:16.04
MAINTAINER b00stfr3ak

RUN apt-get update && apt-get install -y curl ca-certificates --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN curl -Lo /root/nessus-6.7-ubuntu.deb 'http://downloads.nessus.org/nessus3dl.php?file=Nessus-6.7.0-ubuntu1110_amd64.deb&licence_accept=yes&t=894fc1b73118487c63f9a9d40b873dff' \
    && dpkg -i /root/nessus-6.7-ubuntu.deb

ENTRYPOINT ["/opt/nessus/sbin/nessus-service"]
