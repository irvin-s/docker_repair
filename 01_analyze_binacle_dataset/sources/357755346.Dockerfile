FROM ubuntu:18.04
WORKDIR /interop/client

# Set the time zone to the competition time zone.
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

RUN apt-get -qq update && apt-get -qq install -y \
        libxml2-dev \
        libxslt-dev \
        protobuf-compiler \
        python \
        python-dev \
        python-lxml \
        python-nose \
        python-pip \
        python-pyproj \
        python-virtualenv \
        python3 \
        python3-dev \
        python3-nose \
        python3-pip \
        python3-pyproj \
        python3-lxml \
        sudo

COPY client/requirements.txt .

RUN bash -c "cd /interop/client && \
        virtualenv --system-site-packages -p /usr/bin/python2 venv2 && \
        source venv2/bin/activate && \
        pip install -r requirements.txt && \
        deactivate" && \
    bash -c "cd /interop/client && \
        virtualenv --system-site-packages -p /usr/bin/python3 venv3 && \
        source venv3/bin/activate && \
        pip3 install -r requirements.txt && \
        deactivate"

COPY proto/ ../proto
COPY client/ .
RUN bash -c "cd /interop/client && \
        source venv2/bin/activate && \
        python setup.py install && \
        deactivate" && \
    bash -c "cd /interop/client && \
        source venv3/bin/activate && \
        python3 setup.py install && \
        deactivate"

CMD bash --init-file configure.sh
