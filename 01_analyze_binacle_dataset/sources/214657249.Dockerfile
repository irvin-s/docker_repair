FROM nerdammer/hbase:1.1.0.1
MAINTAINER Nicola Ferraro <nibbio84@gmail.com>

ADD start-shell.sh /opt/hbase/bin/start-shell.sh

CMD /opt/hbase/bin/start-shell.sh