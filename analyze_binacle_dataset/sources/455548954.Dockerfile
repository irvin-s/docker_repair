FROM ubuntu:xenial

LABEL Description="Certificate Rotation SPIFFE: Control Plane"
LABEL vendor="SPIFFE"
LABEL version="0.1.0"

COPY conf /spire/.conf
COPY pconf /spire/plugin/server/.conf
COPY artifact.tgz /
COPY upstreamca-memory-keys /spire/keys
RUN tar --directory / -xvzf /artifact.tgz
WORKDIR /spire/

RUN addgroup server && \
   adduser --uid 1111 --disabled-password --shell /bin/bash --ingroup server server

RUN chown -R server /spire
USER server

CMD ./spire-server run
