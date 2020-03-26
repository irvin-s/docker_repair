FROM nerdammer/hbase:0.98.10.1
MAINTAINER Nicola Ferraro <nibbio84@gmail.com>

ADD start-shell.sh /opt/hbase/bin/start-shell.sh

CMD /opt/hbase/bin/start-shell.sh