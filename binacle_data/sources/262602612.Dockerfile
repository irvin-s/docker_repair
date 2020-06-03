# Daniel Malczyk
# ThinkBig Analytics, a Teradata Company

FROM dmalczyk/kstack-hadoopclient:1.0

MAINTAINER Daniel Malczyk <dmalczyk@gmail.com>

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y mysql which; \
    yum clean all

#add kylo user
RUN /bin/bash -c 'useradd -r -m -s /bin/bash kylo;'

#kylo-spark-shell uses this
ENV SPARK_CONF_DIR $SPARK_HOME/conf
RUN echo "export SPARK_CONF_DIR=$SPARK_HOME/conf" >> /etc/profile

# add spark and hadoop path to PATH env variable for kylo user
RUN echo "export PATH=$PATH:/usr/java/default/bin:/usr/local/spark/bin:/usr/local/hadoop/bin" >> /etc/profile

#download and install Kylo rpm
#RUN curl -o /tmp/kylo.rpm -L http://bit.ly/2r4P47A && rpm -ivh /tmp/kylo.rpm && rm /tmp/kylo.rpm
COPY kylo_rpm/kylo.rpm /tmp/kylo.rpm
RUN rpm -ivh /tmp/kylo.rpm && rm /tmp/kylo.rpm

#setup kylo
ENV KYLO_HOME=/opt/kylo
ENV PATH $PATH:$KYLO_HOME
COPY conf/application.properties /opt/kylo/kylo-services/conf/
COPY conf/spark.properties /opt/kylo/kylo-services/conf

# add kylo jars and nars to NiFi container
ENV NIFI_SETUP_DIR $KYLO_HOME/setup/nifi
ENV NIFI_INSTALL_HOME /opt/nifi

#This dir is shared with nifi img
RUN mkdir -p $NIFI_INSTALL_HOME/data/lib/app

RUN cp $NIFI_SETUP_DIR/*.nar $NIFI_INSTALL_HOME/data/lib/
RUN cp $NIFI_SETUP_DIR/kylo-spark-*.jar $NIFI_INSTALL_HOME/data/lib/app/

RUN echo "Kylo - nifi jars and nars copied to shared directory:"
RUN ls $NIFI_INSTALL_HOME/data/lib
RUN ls $NIFI_INSTALL_HOME/data/lib/app

VOLUME $NIFI_INSTALL_HOME/data/lib

# Align the same security.jwt.key as kylo-ui which is generated in kylo post-installation
RUN jwtkey=$(grep 'security.jwt.key' /opt/kylo/kylo-ui/conf/application.properties | awk -F  "=" '/1/ {print $2}') && sed -i "s/security\.jwt\.key=<insert-256-bit-secret-key-here>/security\.jwt\.key=${jwtkey}/" /opt/kylo/kylo-services/conf/application.properties
RUN echo "Kylo Installation complete"

# Add kylo and nifi user to supergroup otherwise kylo-spark-shell service which runs as kylo user will not be able to create database in hive.
RUN groupadd supergroup
RUN usermod -a -G supergroup kylo

# shared volume
RUN mkdir -p /var/share
VOLUME /var/share

COPY scripts/kylo_bootstrap.sh /etc/kylo_bootstrap.sh
RUN chown root.root /etc/kylo_bootstrap.sh
RUN chmod 700 /etc/kylo_bootstrap.sh

ENTRYPOINT ["/etc/kylo_bootstrap.sh"]

EXPOSE 8400
EXPOSE 8888
EXPOSE 8420
