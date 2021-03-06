FROM ubuntu:xenial

MAINTAINER Marek Franciszkiewicz <marek.franciszkiewicz@imapp.pl>

# Prerequisites
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates apt-transport-https \
    git wget curl \
    python-pip python-setuptools python-dev python \
    pkg-config g++ dh-autoreconf \
    libfreeimageplus-dev libjpeg-dev zlib1g-dev libopenexr-dev libgmp-dev libffi-dev libssl-dev \
    libraw15 libdatrie1 libthai0 libpango1.0-0 libilmbase-dev libopenexr-dev

RUN pip install --upgrade pip setuptools
RUN pip install pyinstaller

# Link libfreeimage
RUN ln -s /usr/lib/libfreeimage.so.3 /usr/lib/libfreeimage.so

# Initial installation for faster future rebuilds
RUN git clone https://github.com/golemfactory/golem --depth 1
RUN cd golem && pip install -r requirements.txt
RUN cd golem && python setup.py develop
RUN chmod -R 752 golem

ADD entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
