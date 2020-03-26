FROM ubuntu:xenial

LABEL Description="SPIRE Demo: Blog"
LABEL vendor="scytale.io"
LABEL version="0.1.0"

RUN apt-get update -y
RUN apt-get install -y openssl

#====================
# Setup user accounts
#--------------------
RUN addgroup --gid 1901 spire && \
    adduser --uid 1101 --disabled-password --shell /bin/bash --ingroup spire spire

RUN addgroup --gid 1910 blog && \
    adduser --uid 1111 --disabled-password --shell /bin/bash --ingroup blog blog



WORKDIR /home/aws

COPY conf /cmd/spire-agent/.conf
COPY pconf /plugin/agent/.conf
COPY .artifacts/artifacts.tgz /

COPY sidecar_config.hcl /sidecar/
RUN tar --directory / -xvzf /artifacts.tgz

ENV SPIRE_PLUGIN_CONFIG_DIR=/pconf

#====================
# Setup Python and FlaskBB
#--------------------
RUN apt-get -y install \
    make \
    wget \
    build-essential \
    python \
    python-dev \
    libmysqlclient-dev \
    git

RUN \
   cd /home/ && \
   wget https://bootstrap.pypa.io/get-pip.py && \
   python get-pip.py && \
   rm get-pip.py

RUN \
  cd /home/ && \
  git clone https://github.com/sh4nks/flaskbb.git && \
  cd flaskbb &&\
  pip install -r requirements.txt

COPY flaskbb_requirements.txt /home/flaskbb/
COPY flaskbb.cfg /home/flaskbb/

RUN cd /home/flaskbb &&\
    pip install -r flaskbb_requirements.txt


EXPOSE 8080

#====================
# Setup Ghostunnel
#--------------------
RUN mkdir /home/ghostunnel

COPY /keys/ /keys/
COPY ghostunnel_client.sh /home/ghostunnel/
COPY .artifacts/ghostunnel /home/ghostunnel/

#====================
# Vault setup: Eventually move to its own container
#--------------------

# Create a vault user and group first so the IDs are the same
RUN addgroup --gid 120 vault && \
    adduser --uid 1010 --disabled-password --shell /bin/bash --ingroup vault vault


RUN mkdir -p /vault/logs && \
    mkdir -p /vault/

# TODO


# Expose the logs directory
VOLUME /vault/logs

# Expose the file directory
VOLUME /vault/file


#================
# Final setup
#----------------
WORKDIR /cmd/spire-agent/

# CMD ./spire-agent run
