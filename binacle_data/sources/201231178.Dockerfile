FROM oneops/centos7

WORKDIR /opt
ENV apache_archive="http://archive.apache.org/dist"
ENV c_version="2.1.13"
RUN wget -nv ${apache_archive}/cassandra/${c_version}/apache-cassandra-${c_version}-bin.tar.gz
RUN tar -xzvf apache-cassandra-${c_version}-bin.tar.gz
RUN ln -sf apache-cassandra-${c_version} cassandra
RUN sed -i "s/localhost/cassandra/g" /opt/cassandra/conf/cassandra.yaml
RUN sed -i "s/127.0.0.1/cassandra/g" /opt/cassandra/conf/cassandra.yaml
COPY cassandra.ini /etc/supervisord.d/cassandra.ini

VOLUME /opt/cassandra/data

ENV OO_HOME /home/oneops
EXPOSE 7000 9160
