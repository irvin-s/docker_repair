FROM anroots/sensu:0.3.0

COPY conf.d /etc/sensu/conf.d/

CMD dockerize -template /etc/sensu/conf.d/server.tmpl:/etc/sensu/conf.d/server.json \
	-wait tcp://$RABBITMQ_PORT_5672_TCP_ADDR:5672 \
	-wait tcp://$REDIS_PORT_6379_TCP_ADDR:6379 \
	/opt/sensu/bin/sensu-server -d /etc/sensu/conf.d