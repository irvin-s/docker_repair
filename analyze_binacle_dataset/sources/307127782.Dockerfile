FROM node:8.3.0-alpine

ENV DEEPSTREAM_VERSION 3.0.0
ENV DEEPSTREAM_PATH /opt/deepstream
ENV DEEPSTREAM_CONF /opt/deepstream/conf
ENV DEEPSTREAM_PLUGINS /opt/deepstream/plugins

RUN mkdir -p /opt

WORKDIR /opt

RUN \
	apk --no-cache --virtual build-deps add \
	# Build dependencies necessary for compiling Node.js extensions, etc.
		python=2.7.13-r1 \
		make=4.2.1-r0 \
		g++=6.3.0-r4 \
		git=2.13.0-r0 \
		wget=1.19.1-r2 \
		unzip=6.0-r2 && \
	wget https://github.com/deepstreamIO/deepstream.io/archive/v$DEEPSTREAM_VERSION.zip && \
	unzip v$DEEPSTREAM_VERSION.zip && \
	rm v$DEEPSTREAM_VERSION.zip && \
	mv deepstream.io-$DEEPSTREAM_VERSION deepstream && \
	cd deepstream && \
	npm install --only=production && \
	mkdir plugins && \
	# Build dependencies no longer needed, so delete them all
	apk del build-deps

WORKDIR $DEEPSTREAM_PATH

# 6020: WebSocket
EXPOSE 6020

VOLUME ["/opt/deepstream/conf", "/opt/deepstream/plugins"]

CMD ["./bin/deepstream", "start", "--config", "/opt/deepstream/conf/config.yml", "--lib-dir", "/opt/deepstream/plugins"]
