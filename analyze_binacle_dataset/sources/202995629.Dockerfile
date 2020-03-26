FROM ubuntu:14.04
MAINTAINER datawarehouse <aus-eng-data-warehouse@rmn.com>

# install oracle java 7
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# install impala
RUN mkdir /src
RUN wget -O /etc/apt/sources.list.d/cloudera.list https://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/cloudera.list
RUN wget -O /src/archive.key https://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key
RUN apt-key add /src/archive.key
RUN apt-get update
RUN apt-get install -y impala impala-state-store impala-catalog impala-server impala-shell
RUN sed -i "s/\/var\/log\/impala/\/mnt\/impala\/log/g" /etc/default/impala

# create script to monitor the daemon, serving as a foreground process to alert docker upon failure
RUN \
    >> /src/monitor.sh echo '#!/usr/bin/env bash';\
    >> /src/monitor.sh echo 'cp /mnt/impala/conf/* /etc/impala/conf/';\
    >> /src/monitor.sh echo 'service impala-catalog start';\
    >> /src/monitor.sh echo 'PID=$(ps -ef | grep catalogd | grep -e "^impala" | sed -E "s/\s+/\t/g" | cut -f 2)';\
    >> /src/monitor.sh echo 'tail -F --pid ${PID} /mnt/impala/log/catalogd.INFO'
RUN chmod +x /src/monitor.sh

# http://www.cloudera.com/content/www/en-us/documentation/enterprise/latest/topics/impala_ports.html
EXPOSE 23020 25020 26000

CMD /src/monitor.sh

# many thanks to the following resources:
#    https://github.com/rooneyp1976/docker-impala
#    https://github.com/awslabs/emr-bootstrap-actions/tree/master/impala
