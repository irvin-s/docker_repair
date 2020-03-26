FROM karlstoney/hadoop:latest

HEALTHCHECK CMD curl -f http://localhost:50075/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data

RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

EXPOSE 50075

ADD run.sh /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]
