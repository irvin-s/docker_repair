FROM mariadb:10.2

LABEL Description="SPIRE Demo: Database"
LABEL vendor="scytale.io"
LABEL version="0.1.0"

RUN apt-get update -y
RUN apt-get install -y openssl

#====================
# Setup user accounts
#--------------------

RUN addgroup --gid 201 spire && \
    adduser --uid 2101 --disabled-password --shell /bin/bash --ingroup spire spire

RUN addgroup --gid 210 database && \
    adduser --uid 1111 --disabled-password --shell /bin/bash --ingroup database database

WORKDIR /home/aws

COPY conf /cmd/spire-agent/.conf
COPY pconf /plugin/agent/.conf
COPY .artifacts/artifacts.tgz /
COPY .artifacts/ghostunnel /root/
COPY sidecar_config.hcl /sidecar/



RUN tar --directory / -xvzf /artifacts.tgz

ENV SPIRE_PLUGIN_CONFIG_DIR=/pconf

WORKDIR /cmd/spire-agent/


#====================
# Setup ghostunnel
#--------------------

COPY /keys/ /keys/

RUN mkdir /home/ghostunnel

COPY /keys/ /keys/
COPY ghostunnel_server.sh /home/ghostunnel/
COPY .artifacts/ghostunnel /home/ghostunnel/



EXPOSE 3306
EXPOSE 6306

# CMD ./spire-agent run
