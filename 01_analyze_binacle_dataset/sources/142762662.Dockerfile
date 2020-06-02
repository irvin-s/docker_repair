FROM emmanuel/java-openjdk-7-jre-headless:0.0.2
MAINTAINER Emmanuel Gomez "emmanuel@gomez.io"

# ENV ZOOKEEPER_VERSION 3.4.6
# ADD dist/zookeeper-$ZOOKEEPER_VERSION.tar.gz /opt/
# RUN mv /opt/zookeeper-$ZOOKEEPER_VERSION /opt/zookeeper
# WORKDIR /opt/zookeeper

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y zookeeper

ADD ./conf/configuration.xsl /etc/zookeeper/conf/
ADD ./conf/environment /etc/zookeeper/conf/
ADD ./conf/log4j.properties /etc/zookeeper/conf/
ADD ./conf/zoo.cfg /etc/zookeeper/conf/
ADD ./start.sh /

# Zookeeper client port
EXPOSE 2181
# Zookeeper peer port
EXPOSE 2888
# Zookeeper leader (election) port
EXPOSE 3888

CMD ["/start.sh"]
