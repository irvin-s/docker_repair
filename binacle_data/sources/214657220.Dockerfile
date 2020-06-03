FROM nerdammer/hbase:0.98.10.1
MAINTAINER Nicola Ferraro <nibbio84@gmail.com>

RUN mkdir /phoenix-setup
WORKDIR /phoenix-setup

ADD install-phoenix.sh /phoenix-setup/install-phoenix.sh
RUN ./install-phoenix.sh

WORKDIR /opt/hbase/bin

CMD /opt/hbase/bin/start-pseudo-distributed.sh