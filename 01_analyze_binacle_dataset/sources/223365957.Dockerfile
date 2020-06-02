# sudo docker build -t dreamlab/goffish3-hama-source .

FROM dreamlab/goffish3-hama-base
MAINTAINER dreamlab

USER root

# maven
ENV MAVEN_VERSION 3.3.9
ENV USER_HOME_DIR /root

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY settings-docker.xml /usr/share/maven/ref/


RUN mkdir $HAMA_HOME/properties

ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && \
    chmod 700 /etc/bootstrap.sh

ENV BOOTSTRAP /etc/bootstrap.sh



#GOFFISH COMMAND

ADD goffish /bin
RUN chmod +x /bin/goffish


CMD ["/etc/bootstrap.sh", "-d"]

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 19888 8030 8031 8032 8033 8040 8042 8088 49707 2122
# Mapred ports
#EXPOSE 19888
#Yarn ports
#EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
#EXPOSE 49707 2122   

