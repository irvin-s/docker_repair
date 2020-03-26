FROM anroots/sensu-client:0.3.0

# Install sensu plugins that perform system resource checks
RUN apt-get update && \
	apt-get install -y bc build-essential && \
	sensu-install --verbose -P memory-checks,cpu-checks,disk-checks && \
	apt-get purge -y build-essential && \
	apt-get autoremove -y && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY conf.d /etc/sensu/conf.d/

CMD dockerize \
	-template /etc/sensu/conf.d/rabbitmq.tmpl:/etc/sensu/conf.d/rabbitmq.json \
	-template /etc/sensu/conf.d/client.tmpl:/etc/sensu/conf.d/client.json \
	-wait tcp://$RABBITMQ_PORT_5672_TCP_ADDR:5672 \
	/opt/sensu/bin/sensu-client -d /etc/sensu/conf.d