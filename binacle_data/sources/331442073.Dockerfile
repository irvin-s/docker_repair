FROM ubuntu:16.04
MAINTAINER xavier@rootshell.be

RUN apt-get update && apt-get -y -q install tcpdump openssl socat
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
