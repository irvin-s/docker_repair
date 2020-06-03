FROM karlstoney/hbase:latest

EXPOSE 11060
ADD run.sh /usr/local/bin/run.sh
ADD add_indices.sh /usr/local/bin/add_indices.sh
HEALTHCHECK CMD curl -f http://localhost:11060/indexer || exit 1
CMD ["/usr/local/bin/run.sh"]
