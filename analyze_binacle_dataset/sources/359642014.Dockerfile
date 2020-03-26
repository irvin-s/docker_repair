FROM hypriot/rpi-alpine-scratch:edge

# Add support for cross-builds
COPY qemu-arm-static /usr/bin/

ENV KIBANA_VERSION=4.5.1

RUN apk add --update nodejs curl \
	&& curl -sSL https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz | tar -xz \
	&& mv kibana-${KIBANA_VERSION}-linux-x64 kibana \
	&& rm -r kibana/node \
	&& apk del curl

CMD ["node", "kibana/src/cli", "serve", "-e", "localhost:9200"]
