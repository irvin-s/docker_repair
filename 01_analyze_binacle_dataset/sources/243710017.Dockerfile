FROM karlstoney/hadoop:latest

HEALTHCHECK CMD curl -f http://localhost:50070/ || exit 1

ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name

RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

EXPOSE 50070

ADD run.sh /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]
