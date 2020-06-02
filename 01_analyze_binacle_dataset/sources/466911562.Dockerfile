FROM amd64/alpine

RUN apk add --no-cache bash curl jq \
 && mkdir /nexus-init/

ADD ./scripts /scripts


ENTRYPOINT ["/scripts/init.sh"]
