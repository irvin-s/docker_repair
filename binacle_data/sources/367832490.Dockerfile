FROM uchiwa/uchiwa:0.17.1
MAINTAINER Ando Roots <ando@sqroot.eu>

ENV HTTP_USER=hiro HTTP_PASS=nakamura SENSU_NAME="Default Sensu Datacenter" UCHIWA_HOST="0.0.0.0" UCHIWA_PORT=80 UCHIWA_REFRESH=5
EXPOSE 80

RUN	mkdir /etc/uchiwa

COPY dockerize /usr/local/bin/
COPY config.tmpl /etc/uchiwa/

CMD dockerize -template /etc/uchiwa/config.tmpl:/etc/uchiwa/config.json \
	-wait tcp://$API_PORT_4567_TCP_ADDR:$API_PORT_4567_TCP_PORT \
	/go/bin/uchiwa -c /etc/uchiwa/config.json
