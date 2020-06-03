FROM golang:1.12

ARG PROJECT_PATH
ENV GOPATH=/opt

RUN mkdir -p /opt/src/${PROJECT_PATH}

COPY . /opt/src/${PROJECT_PATH}/

WORKDIR /opt/src/${PROJECT_PATH}
RUN make configure

VOLUME /opt/src/${PROJECT_PATH}

HEALTHCHECK \
	--interval=1m \
	--timeout=10s \
	--retries=3 \
	CMD curl -f http://localhost:8080 || exit 1

ENTRYPOINT ["make", "run"]
