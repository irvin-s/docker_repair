FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV HOME=/home

RUN apt-get update \
  && apt-get install -yq libssl1.0.0 --no-install-recommends \
  && apt-get install -yq libsodium-dev --no-install-recommends \
  && apt-get install -yq libreadline7 --no-install-recommends

VOLUME ["${HOME}"]
COPY entrypoint.sh /sbin/
RUN chmod 755 /sbin/entrypoint.sh
COPY build/src/multiverse* /usr/bin/
COPY multiverse.conf /multiverse.conf
EXPOSE 6811 6812 6815
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["multiverse"]
