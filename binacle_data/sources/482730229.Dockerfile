FROM ubuntu:17.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt install -y apache2 apache2-dev libjansson-dev libcurl4-openssl-dev devscripts libtool libssl-dev
COPY scripts/build_deb.sh /build_deb.sh

CMD /build_deb.sh
