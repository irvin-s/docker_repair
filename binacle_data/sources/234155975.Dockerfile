FROM scratch
MAINTAINER Rafael Jesus <rafaelljesus86@gmail.com>

ADD dist/event-srv /dist/event-srv

ENV EVENT_SRV_PORT="3000"
ENV EVENT_SRV_DB="http://@docker:9200"
ENV EVENT_SRV_BUS="localhost:9093"

ENTRYPOINT ["/event-srv"]
