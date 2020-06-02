FROM docker.elastic.co/elasticsearch/elasticsearch:5.6.10

COPY xlp_dev /tmp/xlp_dev
COPY xlp_init.sh /tmp/
COPY xlp_start.sh /tmp/

USER root
RUN ["/bin/sh", "-c", "/tmp/xlp_init.sh"]

EXPOSE 9200 9300

WORKDIR /usr/share/elasticsearch
USER elasticsearch
CMD ["/bin/sh", "-c", "/tmp/xlp_start.sh"]
