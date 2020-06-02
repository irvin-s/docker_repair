FROM debian:7

COPY requirements.txt /usr/local/src/hawk/requirements.txt

RUN apt-get -qq update && apt-get -qq -y install \
    memcached \
    python-pip \
    imagemagick \
    wget
RUN apt-get -qq update && apt-get -qq -y install libfcgi0ldbl \
    libgcc1 \
    libjpeg8 \
    libmemcached10 \
    libstdc++6 \
    libtiff4 \
	libpng12-0

RUN pip install -q -r /usr/local/src/hawk/requirements.txt
RUN wget --no-verbose http://downloads.klokantech.com/iiifserver/iiifserver-1.0.0.debian-wheezy.amd64.deb
RUN dpkg -i iiifserver-1.0.0.debian-wheezy.amd64.deb
