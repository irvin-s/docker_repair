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

# copy the redhat impala-shell rpm for downstream use (install_impala.rb bootstrap action)
RUN wget -O /src/impala-shell.rpm http://archive-primary.cloudera.com/cdh5/redhat/6/x86_64/cdh/5.6.0/RPMS/x86_64/impala-shell-2.4.0+cdh5.6.0+0-1.cdh5.6.0.p0.112.el6.x86_64.rpm

# create script to monitor the daemon, serving as a foreground process to alert docker upon failure
RUN \
    >> /src/monitor.sh echo '#!/usr/bin/env bash';\
    >> /src/monitor.sh echo 'cp /mnt/impala/conf/* /etc/impala/conf/';\
    >> /src/monitor.sh echo 'NAMENODE=$(cat /mnt/impala/conf/masterPrivateDnsName.txt)';\
    >> /src/monitor.sh echo 'sed -i "s/127\.0\.0\.1/${NAMENODE}/g" /etc/default/impala';\
    >> /src/monitor.sh echo 'cp /src/impala-shell.rpm /mnt/impala/';\
    >> /src/monitor.sh echo 'service impala-server start';\
    >> /src/monitor.sh echo 'PID=$(ps -ef | grep impalad | grep -e "^impala" | sed -E "s/\s+/\t/g" | cut -f 2)';\
    >> /src/monitor.sh echo 'tail -F --pid ${PID} /mnt/impala/log/impalad.INFO'
RUN chmod +x /src/monitor.sh

# http://www.cloudera.com/content/www/en-us/documentation/enterprise/latest/topics/impala_ports.html
EXPOSE 21000 21050 22000 23000 25000

CMD /src/monitor.sh

# many thanks to the following resources:
#    https://github.com/rooneyp1976/docker-impala
#    https://github.com/awslabs/emr-bootstrap-actions/tree/master/impala
