FROM 2breakfast/hadoop:centos7-2.7.3-base  
MAINTAINER Weitao Zhou <wtzhou@dataman-inc.com>  
  
ENV HDFS_DATANODE_ROOT_DIR=/var/hdfs/datanode  
ENV HDFS_NAMENODE_RPC_HOST=0.0.0.0  
ENV HDFS_NAMENODE_RPC_PORT=8020  
ENV JAVA_HOME=/usr/java/jdk1.7.0_80/  
ENV PUBLISHED_IP=please_input_host_ip  
  
ADD conf/* ${HADOOP_INSTALL_DIR}/etc/hadoop/  
ADD docker-entrypoint.sh /usr/local/sbin/docker-entrypoint.sh  
  
VOLUME ["${HDFS_DATANODE_ROOT_DIR}"]  
  
# TCP 50010 dfs.datanode.address port for data transfer  
# TCP 50020 dfs.datanode.ipc.address ipc server  
# TCP 50075 dfs.datanode.http.address http server  
# TCP 50475 dfs.datanode.https.address https server  
EXPOSE 50010 50020 50075 50475  
RUN chmod a+x /usr/local/sbin/docker-entrypoint.sh  
  
ENTRYPOINT ["/usr/local/sbin/docker-entrypoint.sh"]  
  
CMD ["bin/hdfs", "datanode"]  

