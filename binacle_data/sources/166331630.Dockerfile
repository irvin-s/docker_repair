
FROM oddpoet/jdk7
MAINTAINER Yunsang Choi <oddpoet@gmail.com>

ENV CDH_VER 5.2.0

#=======================
# Install HBase
#=======================
# ref : http://www.cloudera.com/content/cloudera-content/cloudera-docs/CDH5/latest/CDH5-Quick-Start/cdh5qs_yarn_pseudo.html
RUN curl http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/cloudera-cdh5.repo -o /etc/yum.repos.d/cloudera-cdh5.repo
RUN sed -i "s|cdh/5/|cdh/${CDH_VER}/|" /etc/yum.repos.d/cloudera-cdh5.repo
RUN yum install -y hadoop-conf-pseudo hbase hbase-master hbase-regionserver


#=======================
# Configure HBase pseduo-distributed
#=======================
COPY setup.sh setup.sh
RUN ["/bin/bash", "setup.sh"]

#=======================
# Start services.
#=======================
COPY hbase-site.xml /etc/hbase/conf/hbase-site.xml 
COPY core-site.xml /etc/hadoop/conf/core-site.xml

COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]
CMD []
