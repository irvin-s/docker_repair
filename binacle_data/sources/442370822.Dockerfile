# Dockerfile for CDH3 master
# 

FROM teco/cdh3-hadoop-base

MAINTAINER wildschu@teco.edu

# Namenode
EXPOSE 8020:8020 50070:50070 50470:50470
# Secondary Namenode
EXPOSE 50090:50090 50495:50495
# Jobtracker
EXPOSE 8021:8021 50030:50030
# Zookeeper
EXPOSE 2181:2181

RUN rm -rf /var/lib/hadoop-0.20/cache/hadoop/dfs; \
mkdir -p /var/lib/hadoop-0.20/cache/hadoop/dfs/name; \
mkdir -p /var/lib/hadoop-0.20/cache/hadoop/dfs/data; \
chown hdfs:hdfs /var/lib/hadoop-0.20/cache/hadoop/dfs/name; \
chown hdfs:hdfs /var/lib/hadoop-0.20/cache/hadoop/dfs/data;
USER hdfs
RUN yes 'Y' | hadoop namenode -format;
USER root

ADD run.sh run.sh
ENTRYPOINT ["sh","run.sh"]