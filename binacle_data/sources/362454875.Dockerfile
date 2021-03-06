FROM mayjojo/hawq-devel:centos7

MAINTAINER Zhanwei Wang <wangzw@wangzw.org>

USER root

# install HDP 2.3.2
RUN curl -L "http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.3.2.0/hdp.repo" -o /etc/yum.repos.d/hdp.repo && \
 yum install -y hadoop hadoop-hdfs hadoop-libhdfs hadoop-yarn hadoop-mapreduce hadoop-client hdp-select && \
 yum clean all

RUN ln -s /usr/hdp/current/hadoop-hdfs-namenode/../hadoop/sbin/hadoop-daemon.sh /usr/bin/hadoop-daemon.sh

COPY conf/* /etc/hadoop/conf/

COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY start-hdfs.sh /usr/bin/start-hdfs.sh

USER gpadmin

ENTRYPOINT ["entrypoint.sh"]
CMD ["bash"]

