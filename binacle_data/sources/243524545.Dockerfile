FROM alpine:3.5
RUN \
	echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> \
		/etc/apk/repositories && \
	apk add --update tor && \
	rm -rf /var/cache/apk/*
ADD docker-entrypoint.sh /
ENTRYPOINT ["sh", "./docker-entrypoint.sh"]
