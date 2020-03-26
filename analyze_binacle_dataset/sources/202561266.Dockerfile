FROM hypriot/rpi-python

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    gcc \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN pip install bottle \
    docker-py \
    glances \
    netifaces \
    psutil \
    statsd 

EXPOSE 61208

#CMD ["glances", "-w"]
CMD ["glances"]
