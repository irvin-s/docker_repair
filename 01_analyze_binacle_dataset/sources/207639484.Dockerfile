FROM centos:7

MAINTAINER  Jemish Patel <jpatel@pivotal.io>

# install document with yum
RUN sed -i 's/tsflags=nodocs//g' /etc/yum.conf

# add yum repo for libhdfs3
#RUN curl -L "https://bintray.com/wangzw/rpm/rpm" -o /etc/yum.repos.d/bintray-wangzw-rpm.repo

RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm && \
 yum history sync && yum -y update  && yum clean all


# install software we need to build
RUN yum -y swap -- remove systemd-container systemd-container-libs -- install systemd systemd-libs && \
 yum makecache && \
 yum install -y man passwd sudo tar which git mlocate links make bzip2 net-tools \
 autoconf automake libtool m4 gcc gcc-c++ gdb bison flex cmake3 gperf maven indent \
 libuuid-devel krb5-devel libgsasl-devel expat-devel libxml2-devel \
 perl-ExtUtils-Embed pam-devel python-devel libcurl-devel snappy-devel \
 thrift-devel libyaml-devel libevent-devel bzip2-devel openssl-devel \
 openldap-devel protobuf-devel readline-devel net-snmp-devel apr-devel \
 libesmtp-devel xerces-c-devel python-pip json-c-devel libhdfs3-devel \
 apache-ivy java-1.7.0-openjdk-devel libffi libffi-devel unzip\
 openssh-clients openssh-server R tcpdump wget bsdtar perl-JSON && \
 yum clean all


# install python module
RUN yum makecache && yum install -y postgresql-devel && \
 pip --retries=50 --timeout=300 install --upgrade pip && \
 pip --retries=50 --timeout=300 install pg8000 simplejson unittest2 pycrypto pygresql pyyaml lockfile paramiko psi && \
 pip --retries=50 --timeout=300 install http://darcs.idyll.org/~t/projects/figleaf-0.6.1.tar.gz && \
 pip --retries=50 --timeout=300 install http://sourceforge.net/projects/pychecker/files/pychecker/0.8.19/pychecker-0.8.19.tar.gz/download && \
 pip --retries=50 --timeout=300 install  numpy scipy matplotlib plotly psycopg2 queries pandas sqlalchemy redis python-dotenv && \
 yum clean all

# setup ssh server and keys for root
RUN sshd-keygen && \
 ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa && \
 cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
 chmod 0600 ~/.ssh/authorized_keys

# setup JAVA_HOME for all users
RUN echo "#!/bin/sh" > /etc/profile.d/java.sh && \
 echo "export JAVA_HOME=/etc/alternatives/java_sdk" >> /etc/profile.d/java.sh && \
 chmod a+x /etc/profile.d/java.sh

#link correct cmake
RUN cd /usr/bin/ && ln -s cmake3 cmake && ln -s ccmake3 ccmake && ln -s cpack3 cpack && ln -s ctest3 ctest

# install libyarn
#RUN mkdir -p /tmp/build && \
# cd /tmp/build && git clone --depth=1 https://github.com/apache/incubator-hawq.git . && cd depends/libyarn && mkdir build && cd build && \
# ../bootstrap --prefix=/usr && make -j4 && make install && ldconfig && \
# rm -rf /tmp/build

# install libhdfs3
#RUN mkdir -p /tmp/build && \
# cd /tmp/build && git clone --recursive --depth=1 https://github.com/apache/incubator-hawq.git . && cd depends/libhdfs3 && mkdir build && cd build && \
 #../bootstrap --prefix=/data/hdb2 && make && make install && ldconfig && \
 #rm -rf /tmp/build


# sudo should not require tty
RUN sed -i -e 's|Defaults    requiretty|#Defaults    requiretty|' /etc/sudoers

# set USER env
RUN echo "#!/bin/bash" > /etc/profile.d/user.sh && \
 echo "export USER=\`whoami\`" >> /etc/profile.d/user.sh && \
 chmod a+x /etc/profile.d/user.sh
ENV BASEDIR /data
RUN mkdir -p /data && chmod 777 /data

USER root

# install HDP 2.4.0.0
RUN curl -L "http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.4.0.0/hdp.repo" -o /etc/yum.repos.d/hdp.repo && \
 yum -y update && yum install -y hadoop hadoop-hdfs hadoop-libhdfs hadoop-yarn hadoop-mapreduce hadoop-client hdp-select && \
 yum clean all

RUN ln -s /usr/hdp/current/hadoop-hdfs-namenode/../hadoop/sbin/hadoop-daemon.sh /usr/bin/hadoop-daemon.sh

# create user gpadmin since HAWQ cannot run under root
RUN groupadd -g 1000 gpadmin && \
 useradd -u 1000 -g 1000 -G hdfs,hadoop gpadmin && \
 echo "gpadmin  ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/gpadmin

COPY conf/* /etc/hadoop/conf/

COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY start-hdfs.sh /usr/bin/start-hdfs.sh
COPY start-hdb2.sh /usr/bin/start-hdb.sh
COPY start-zepp.sh /usr/bin/start-zepp.sh
COPY start-scdf.sh /usr/bin/start-scdf.sh
COPY madlib-1.9-1.x86_64.rpm /tmp/madlib-1.9-1.x86_64.rpm


# Install HDB2

USER gpadmin

# setup ssh client keys for gpadmin
RUN ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa && \
 cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
 chmod 0600 ~/.ssh/authorized_keys

RUN git clone https://github.com/apache/incubator-hawq.git /data/hawq && \
 cd /data/hawq && ./configure --prefix=/data/hdb2 --with-python  \
 --with-r --with-ldap --with-pam --with-gssapi --with-openssl --with-krb5 --enable-orca --enable-debug \
 && make -j4 && make install && make clean

# Install PXf
USER root

RUN cd /data/hawq/pxf && ./gradlew clean tomcatRpm release -x test -Dhd=hdp && \
cd /data/hawq/pxf/distributions/ && rpm -i *.rpm && \
cd /data/hawq/pxf/build/distributions/ && rpm -i --force --nodeps pxf*.rpm && \
cd /data/hawq/pxf/ && \
./gradlew clean && \
rm -rf /data/hawq/pxf/distributions && \
rm -rf /data/hawq && yum history sync && yum clean all

# Adding PXF User to superuser group for HDFS access

RUN groupadd supergroup && \
 usermod -G supergroup -a pxf

# Install SCDF
RUN git clone https://github.com/spring-cloud/spring-cloud-dataflow.git /data/scdf && \
cd /data/scdf && ./mvnw clean install && \
cp /data/scdf/spring-cloud-dataflow-server-local/target/spring-cloud-dataflow-server-local-*.BUILD-SNAPSHOT.jar /data/ && \
cp /data/scdf/spring-cloud-dataflow-shell/target/spring-cloud-dataflow-shell-*.BUILD-SNAPSHOT.jar /data/ && \
./mvnw clean && \
rm -rf /data/scdf

USER gpadmin

WORKDIR /data
#EXPOSE 5432 22 8020 51200
ENTRYPOINT ["entrypoint.sh"]
CMD ["bash"]
