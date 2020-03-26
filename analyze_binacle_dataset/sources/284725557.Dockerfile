FROM docker.elastic.co/kibana/kibana:5.6.10

COPY xlp_dev /tmp/xlp_dev
COPY xlp_init.sh /tmp/
COPY xlp_start.sh /tmp/

USER root
RUN ["/bin/sh", "-c", "/tmp/xlp_init.sh"]

EXPOSE 5601

WORKDIR /usr/share/kibana
USER kibana
CMD ["/bin/sh", "-c", "/tmp/xlp_start.sh"]
