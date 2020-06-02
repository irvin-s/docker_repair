FROM centos:centos6

MAINTAINER SnappyData, Inc.

USER root

RUN yum -y install epel-release nss_wrapper gettext && \
    yum -y install curl which tar sudo openssh-server openssh-clients passwd supervisor bind-utils nc wget && \
    yum -y install java-1.8.0-openjdk && \
    yum clean all -y

RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

ENV PATH $PATH:$JAVA_HOME/bin

# Modify the url of the SnappyData tarball with your tarball and also the corresponding extracted directory name.
RUN wget -q -O /opt/snappydata.tar.gz https://github.com/SnappyDataInc/snappydata/releases/download/v1.1.0/snappydata-1.1.0-bin.tar.gz && \
    tar -C /opt -xf /opt/snappydata.tar.gz && \
    mv /opt/snappydata-1.1.0-bin /opt/snappydata && \
    rm -f /opt/snappydata-1.1.0-bin.tar.gz && \
    wget -q -O /opt/snappydata/jars/gcs-connector-latest-hadoop2.jar https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-latest-hadoop2.jar && \
    chgrp -R 0 /opt/snappydata && \
    chmod -R g+rw /opt/snappydata && \
    find /opt/snappydata -type d -exec chmod g+x {} +

COPY start /usr/local/bin/
RUN chmod o+x /usr/local/bin/start
WORKDIR /opt/snappydata

EXPOSE 5050

CMD ["/usr/local/bin/start", "all"]
