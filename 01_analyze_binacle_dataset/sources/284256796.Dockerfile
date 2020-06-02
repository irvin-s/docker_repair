FROM datalayer/hdfs-base:2.9.0

ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

ADD entry-point.sh /entry-point.sh
RUN chmod a+x /entry-point.sh

CMD ["/entry-point.sh"]
