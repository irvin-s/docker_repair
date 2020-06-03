# Daniel Malczyk
# ThinkBig Analytics, a Teradata Company

#basic image with CentOS and latest JDK
FROM dmalczyk/kstack-hadoopclient:1.0

MAINTAINER Daniel Malczyk <dmalczyk@gmail.com>

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which; \
    yum clean all

ENV NIFI_INSTALL_HOME /opt/nifi
ENV NIFI_USER nifi
ENV NIFI_GROUP users

# create nifi user and group
RUN /bin/bash -c 'useradd -r -m -s /bin/bash nifi'

# download and install NiFi with Kylo-provided script
COPY conf/install-nifi.sh .
RUN chmod u+x ./install-nifi.sh && \
    ./install-nifi.sh $NIFI_INSTALL_HOME $NIFI_USER $NIFI_GROUP

VOLUME $NIFI_INSTALL_HOME/data/lib

#configure kylo/nifi integration
#this part follows install-kylo-components.sh script
RUN echo -e "\n\n# Set kylo nifi configuration file directory path" >> $NIFI_INSTALL_HOME/current/conf/bootstrap.conf
RUN echo -e "java.arg.15=-Dkylo.nifi.configPath=$NIFI_INSTALL_HOME/ext-config" >> $NIFI_INSTALL_HOME/current/conf/bootstrap.conf

RUN echo "Installing the kylo libraries to the NiFi lib"
RUN mkdir $NIFI_INSTALL_HOME/current/lib/app
#$NIFI_INSTALL_HOME/data/lib is shared with Kylo img
RUN mkdir -p $NIFI_INSTALL_HOME/data/lib/app

RUN echo "Script for linking kylo jars to nifi libs, $NIFI_INSTALL_HOME"
COPY conf/create-symbolic-links.sh $NIFI_INSTALL_HOME
RUN chmod u+x $NIFI_INSTALL_HOME/create-symbolic-links.sh

# Download mysql jdbc driver and prepare hive metastore.
RUN mkdir -p /opt/nifi/mysql
RUN curl -s -o /opt/nifi/mysql/mysql-connector-java-5.1.41.jar http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.41/mysql-connector-java-5.1.41.jar
RUN curl -s -o /opt/nifi/mysql/mariadb-java-client-1.5.7.jar https://downloads.mariadb.com/Connectors/java/connector-java-1.5.7/mariadb-java-client-1.5.7.jar

RUN echo "Copy the activeMQ required jars for the JMS processors to $NIFI_INSTALL_HOME/activemq"
RUN mkdir $NIFI_INSTALL_HOME/activemq
#COPY activemq/*.jar $NIFI_INSTALL_HOME/activemq/
RUN curl -s -o $NIFI_INSTALL_HOME/activemq/activemq-client-5.13.1.jar http://repo1.maven.org/maven2/org/apache/activemq/activemq-client/5.13.1/activemq-client-5.13.1.jar
RUN curl -s -o $NIFI_INSTALL_HOME/activemq/geronimo-j2ee-management_1.1_spec-1.0.1.jar http://repo1.maven.org/maven2/org/apache/geronimo/specs/geronimo-j2ee-management_1.1_spec/1.0.1/geronimo-j2ee-management_1.1_spec-1.0.1.jar
RUN curl -s -o $NIFI_INSTALL_HOME/activemq/hawtbuf-1.11.jar http://repo1.maven.org/maven2/org/fusesource/hawtbuf/hawtbuf/1.11/hawtbuf-1.11.jar

RUN echo "setting up temporary database in case JMS goes down"
RUN mkdir $NIFI_INSTALL_HOME/h2
RUN mkdir $NIFI_INSTALL_HOME/ext-config

COPY conf/config.properties $NIFI_INSTALL_HOME/ext-config
RUN chown -R $NIFI_USER:$NIFI_GROUP $NIFI_INSTALL_HOME

RUN echo "Creating flow file cache directory"
RUN mkdir $NIFI_INSTALL_HOME/feed_flowfile_cache/
RUN chown $NIFI_USER:$NIFI_GROUP $NIFI_INSTALL_HOME/feed_flowfile_cache/

RUN mkdir /var/log/nifi && \
    chown $NIFI_USER:$NIFI_GROUP /var/log/nifi

RUN echo "Creating the dropzone folder" && mkdir -p /var/dropzone
RUN chown nifi:nifi /var/dropzone
RUN chmod 774 /var/dropzone/

#sample data to run after kylo start
COPY sample_data/* /var/sampledata/
RUN chown -R nifi:nifi /var/sampledata

RUN groupadd supergroup
RUN usermod -a -G supergroup nifi

COPY scripts/nifi_bootstrap.sh /etc/nifi_bootstrap.sh
RUN chown root.root /etc/nifi_bootstrap.sh && \
    chmod u+x /etc/nifi_bootstrap.sh

ENTRYPOINT ["/etc/nifi_bootstrap.sh"]

# expose NiFi UI
EXPOSE 8079
