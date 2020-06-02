FROM datalayer/hdfs-base:2.9.0

ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

ADD entry-point.sh /entry-point.sh
RUN chmod a+x /entry-point.sh

CMD ["/entry-point.sh"]
