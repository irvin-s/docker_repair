FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && apt-get install --no-install-recommends -y alien wget unzip clinfo
RUN apt-get install -y build-essential ca-certificates zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev


# [ Python 3.7.1 ] ================================================================
WORKDIR /tmp
RUN wget https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz
RUN tar -xzvf Python-3.7.1.tgz
WORKDIR /tmp/Python-3.7.1
RUN ./configure && make && make install
WORKDIR /tmp
RUN rm -rf /tmp/Python-3.7.1

# ================================================================
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# Create work directory
RUN mkdir /opt/distgen/
WORKDIR /opt/distgen/

# Entrypoint
COPY docker-entrypoint.sh /opt/distgen/

# Health check
COPY healthcheck.py /opt/distgen/

# The core stuff
COPY algorithms.py /opt/distgen/
COPY distgen_compute.py /opt/distgen/
COPY generate_seeded_keyspace.py /opt/distgen/


EXPOSE 80

ENTRYPOINT /opt/distgen/docker-entrypoint.sh