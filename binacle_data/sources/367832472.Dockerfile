FROM anroots/sensu:0.3.0

ENV DOCKERCLOUD_NODE_FQDN= DOCKERCLOUD_IP_ADDRESS= SUBSCRIPTIONS=

COPY conf.d /etc/sensu/conf.d/

CMD dockerize -template /etc/sensu/conf.d/rabbitmq.tmpl:/etc/sensu/conf.d/rabbitmq.json \
	-wait tcp://$RABBITMQ_PORT_5672_TCP_ADDR:5672 \
	/opt/sensu/bin/sensu-client -d /etc/sensu/conf.d