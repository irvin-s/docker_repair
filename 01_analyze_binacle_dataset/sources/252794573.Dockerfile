FROM dataman/hadoop-base:2.7.1  
MAINTAINER Weitao Zhou <wtzhou@dataman-inc.com>  
  
ENV HDFS_NAMENODE_ROOT_DIR=/var/hdfs/namenode  
ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64  
  
ADD conf/core-site.xml ${HADOOP_INSTALL_DIR}/etc/hadoop/core-site.xml  
ADD conf/hdfs-site.xml ${HADOOP_INSTALL_DIR}/etc/hadoop/hdfs-site.xml  
  
ADD docker-entrypoint.sh /usr/local/sbin/docker-entrypoint.sh  
  
VOLUME ["${HDFS_NAMENODE_ROOT_DIR}"]  
  
# TCP 8020 fs.defaultFS IPC: ClientProtocol  
# TCP 50070 dfs.namenode.http-address HTTP connector  
# TCP 50470 dfs.namenode.https-address HTTPS connector  
EXPOSE 8020 50070 50470  
RUN chmod a+x /usr/local/sbin/docker-entrypoint.sh  
  
ENTRYPOINT ["/usr/local/sbin/docker-entrypoint.sh"]  
  
CMD ["bin/hdfs", "namenode"]  

