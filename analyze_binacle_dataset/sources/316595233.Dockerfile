FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV HOME=/home/fnfn

RUN apt-get update \
  && apt-get install -yq libssl-dev --no-install-recommends \
  && apt-get install -yq libsodium-dev --no-install-recommends \
  && apt-get install -yq libreadline6-dev --no-install-recommends

VOLUME ["${HOME}"]
COPY entrypoint.sh /sbin/
RUN chmod 755 /sbin/entrypoint.sh
COPY build/multiverse* /usr/bin/
COPY multiverse.conf /multiverse.conf
EXPOSE 6811 6812 6815
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["multiverse"]
