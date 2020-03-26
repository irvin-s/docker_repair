FROM anroots/sensu:0.3.0

ENV API_USER=WqNu4awAaNoP API_PASS=abcXvzSqoSw7
EXPOSE 4567

COPY conf.d /etc/sensu/conf.d/

CMD dockerize -template /etc/sensu/conf.d/api.tmpl:/etc/sensu/conf.d/api.json \
	-wait tcp://$RABBITMQ_PORT_5672_TCP_ADDR:5672 \
	-wait tcp://$REDIS_PORT_6379_TCP_ADDR:6379 \
	/opt/sensu/bin/sensu-api -d /etc/sensu/conf.d