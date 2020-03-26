FROM resin/raspberrypi3-debian:stretch
RUN apt-get update && \
    apt-get dist-upgrade && \
    apt-get install apt-transport-https build-essential python python-pip python-setuptools python-dev cython curl && \
    curl https://apt.matrix.one/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.matrix.one/raspbian stretch main" > /etc/apt/sources.list.d/matrixlabs.list && \
    apt-get update && \
    apt-get install libmatrixio-creator-hal-dev && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/app
COPY . .
RUN pip install -r requirements.txt
ENTRYPOINT ["/sbin/tini", "-g",  "--"]
STOPSIGNAL SIGTERM
CMD [ "python", "./led_rotate.py" ]
