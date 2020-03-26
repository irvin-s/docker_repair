FROM offlineregistry.dataman-inc.com:5000/library/mycat-base:latest
MAINTAINER yhchen <yhchen@dataman-inc.com>

COPY data/ /data/
EXPOSE 8066 9066

CMD ["/bin/bash", "-c", "sh -x /data/mycat/bin/start_mycat.sh"]
