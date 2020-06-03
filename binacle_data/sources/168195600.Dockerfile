FROM mattdm/fedora-small:f20


ADD https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz /tmp/
RUN yum install -y python-twisted tar && \
	mkdir -p /web/ && \
	tar -C /web -xf /tmp/kibana-3.1.0.tar.gz && \
	rm -f /tmp/kibana-3.1.0.tar.gz && \
	ln -s /web/kibana-3.1.0 /web/kibana && \
	cp /web/kibana/app/dashboards/logstash.json /web/kibana/app/dashboards/default.json 
ADD ./run.sh /run.sh
RUN chmod a+x /run.sh

VOLUME /web/kibana/app/dashboards
VOLUME /config

# HTTP interface
EXPOSE 8080

USER nobody
WORKDIR /tmp
CMD ["/run.sh"]
