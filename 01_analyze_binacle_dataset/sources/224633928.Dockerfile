FROM offlineregistry.dataman-inc.com:5000/library/centos7-base:latest
MAINTAINER yhchen <yhchen@dataman-inc.com>

RUN mkdir -p /data
COPY data/ /data/
COPY etc/ /etc/

RUN cd /data/ && rpm -ivh jdk-8u131-linux-x64.rpm && \
tar -zxf Mycat-server-1.5.1-RELEASE-20161130213509-linux.tar.gz
ENV JAVA_HOME=/usr/java/jdk1.8.0_131
ENV PATH=$JAVA_HOME/bin:/data/mycat/bin:$PATH

EXPOSE 8066 9066

CMD ["/bin/bash", "-c","sh -x /data/mycat/bin/start_mycat.sh"]
