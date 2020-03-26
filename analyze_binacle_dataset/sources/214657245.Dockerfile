FROM nerdammer/hbase-phoenix:1.1.0.1-4.4.0
MAINTAINER Nicola Ferraro <nibbio84@gmail.com>

WORKDIR /opt/phoenix/bin
ADD start-phoenix-shell.sh /opt/phoenix/bin/start-phoenix-shell.sh

CMD ./start-phoenix-shell.sh