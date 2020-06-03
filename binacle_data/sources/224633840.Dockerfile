FROM offlineregistry.dataman-inc.com:5000/library/centos7-base:latest
MAINTAINER yhchen <yhchen@dataman-inc.com>

RUN mkdir -p /data && cd /data && \
yum -y install wget && \
yum clean all && \
wget http://archive.apache.org/dist/activemq/5.13.1/apache-activemq-5.13.1-bin.tar.gz

COPY data/ /data/
RUN cd /data/ && rpm -ivh jdk-8u131-linux-x64.rpm && \
tar -zxf apache-activemq-5.13.1-bin.tar.gz 
ENV JAVA_HOME=/usr/java/jdk1.8.0_131
ENV PATH=$JAVA_HOME/bin:/data/apache-activemq-5.13.1/bin:$PATH

EXPOSE 61616 5672 61613 1883 61614 8161 8162

CMD ["/bin/bash", "-c", "sh -x /data/apache-activemq-5.13.1/bin/start_active-mq.sh"]
