FROM oneops/centos7

WORKDIR /opt
ENV apache_archive="http://archive.apache.org/dist"
ENV amq_version="5.10.2"
RUN wget -nv ${apache_archive}/activemq/${amq_version}/apache-activemq-${amq_version}-bin.tar.gz
RUN tar -xzvf apache-activemq-${amq_version}-bin.tar.gz
RUN ln -sf ./apache-activemq-${amq_version} activemq
RUN mkdir -p ./activemq/data
RUN ln -sf ./activemq/data/kahadb /kahadb
RUN echo "activemq.username=system" > /opt/activemq/conf/credentials.properties
RUN echo "activemq.password=amqpass" >> /opt/activemq/conf/credentials.properties
COPY activemq.ini /etc/supervisord.d/activemq.ini
COPY activemq.sh /opt/activemq.sh
RUN chmod +x /opt/activemq.sh

VOLUME /kahadb

ENV OO_HOME /home/oneops
EXPOSE 61616 61617 8161
