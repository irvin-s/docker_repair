FROM karlstoney/hadoop:latest

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/hadoop/yarn/timeline
RUN mkdir -p /hadoop/yarn/timeline
VOLUME /hadoop/yarn/timeline

EXPOSE 8188

ADD run.sh /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]
