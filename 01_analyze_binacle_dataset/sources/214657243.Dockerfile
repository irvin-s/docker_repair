FROM nerdammer/hbase-phoenix:0.98.10.1-4.3.1
MAINTAINER Nicola Ferraro <nibbio84@gmail.com>

WORKDIR /opt/phoenix/bin
ADD start-phoenix-shell.sh /opt/phoenix/bin/start-phoenix-shell.sh

CMD ./start-phoenix-shell.sh