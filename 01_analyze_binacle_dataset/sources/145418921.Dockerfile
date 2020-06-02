FROM gliderlabs/alpine:3.4

ARG bind=0.0.0.0:5050
ARG http=127.0.0.1:8080

RUN apk update && \
	apk add wget make go git gcc musl-dev && \
	mkdir -p /var/lib/dfi && \
	cd /var/lib/dfi && \
	git clone https://github.com/dfi/dfi src && \
	cd src && make && cd ../ && \
	cp src/bin/dfid . && \
	wget --no-check-certificate https://willhuxtable.com/dfid.toml && \
	chmod +x dfid

EXPOSE 8080
EXPOSE 5050
CMD cd /var/lib/dfi && ./dfid --bind ${bind} --http ${http}
