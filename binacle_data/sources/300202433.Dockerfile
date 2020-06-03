FROM pypy:3-slim

MAINTAINER Adam Wallner <adam.wallner@gmail.com>

COPY portredirector.py /opt/
COPY docker_entry.sh /opt/

RUN \
    # Install needed packages
    apt-get update && apt-get install -y iptables \
    # Make entry script working with pypy
    && ln -s /usr/local/bin/pypy3 /usr/local/bin/python3 \
    # Install python modules
    && pip3 install async_timeout \
    # Clean unneeded packages
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

ENTRYPOINT ["/opt/docker_entry.sh"]
