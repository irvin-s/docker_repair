FROM ubuntu

ADD . /workdir
WORKDIR /workdir

RUN apt update && apt install -y python3 wget && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && pip3 install numpy && \
    ls /workdir && cd /workdir/python && python3 setup.py install
