FROM scratch
MAINTAINER Rafael Jesus <rafaelljesus86@gmail.com>
ADD cron-srv /cron-srv
ENV CRON_SRV_DB="postgres://postgres:@docker/cron_srv?sslmode=disable"
ENV CRON_SRV_PORT="3000"
ENTRYPOINT ["/cron-srv"]
