FROM counterparty/base

MAINTAINER Counterparty Developers <dev@counterparty.io>

# Install extra counterblock deps
RUN apt-get update && apt-get -y install libjpeg8-dev libgmp-dev libzmq3-dev libxml2-dev libxslt-dev zlib1g-dev libimage-exiftool-perl libevent-dev cython

# Install
COPY . /counterblock
WORKDIR /counterblock
RUN pip3 install -r requirements.txt
RUN python3 setup.py develop

COPY docker/server.conf /root/.config/counterblock/server.conf
COPY docker/modules.conf /root/.config/counterblock/modules.conf
COPY docker/counterwallet.conf /root/.config/counterblock/counterwallet.conf
COPY docker/start.sh /usr/local/bin/start.sh
RUN chmod a+x /usr/local/bin/start.sh

EXPOSE 4100 4101 4102 14100 14101 14102

ENTRYPOINT ["start.sh"]
