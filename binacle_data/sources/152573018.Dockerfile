# Simple hadoop install for testing.
FROM piggybanksqueal/base
MAINTAINER James Lampton <jlampton@gmail.com>

RUN yum install -y which supervisor

RUN test -e /opt/java_home || ln -s $(dirname $(dirname $(readlink -f $(which java)))) /opt/java_home
ENV JAVA_HOME /opt/java_home
ENV HADOOP_CONF_DIR /opt/hadoop/etc/hadoop

RUN useradd hdfs && useradd yarn && mkdir /opt/hadoop/logs && chmod 777 /opt/hadoop/logs

ADD configure_and_start_hadoop.sh /opt/hadoop/
ADD setup_hdfs.sh /opt/hadoop/

ADD supervisor.d/*.ini /etc/supervisor.d/
RUN cat /etc/supervisor.d/*.ini >> /etc/supervisord.conf

# HDFS
# -- namenode
EXPOSE 50070

# YARN
# -- resourcemanager
EXPOSE 8088

ENTRYPOINT ["/opt/hadoop/configure_and_start_hadoop.sh"]
