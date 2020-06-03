# WARNING: Cross-build doesn't work
FROM hypriot/rpi-alpine-scratch

ENV FLUENTD_VERSION=0.14.0.pre.1

RUN apk --update add build-base ca-certificates ruby ruby-dev ruby-irb \
	&& apk add build-base \
	&& gem update --system --no-document \
	&& gem install --no-document json \
	&& gem install --no-document json_pure jemalloc \
	&& gem install --no-document fluentd -v ${FLUENTD_VERSION} \
	&& gem install --no-document fluent-plugin-elasticsearch \
	&& gem install --no-document fluent-plugin-kubernetes_metadata_filter \
	&& apk del build-base \
	&& rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

COPY fluent.conf /etc/fluent/fluent.conf

CMD ["fluentd"]
