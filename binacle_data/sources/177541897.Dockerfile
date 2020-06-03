FROM raintank/nodejsgo

ENV GOPATH /go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

RUN apt-get -y install wget vim bc
# RUN mkdir -p /go/src/github.com/grafana
# RUN cd /go/src/github.com/grafana && \
# 	git clone https://github.com/raintank/grafana-api-golang-client.git && \
 # 	cd grafana-api-golang-client && \
 # 	git checkout raintank && \
 # 	go get github.com/raintank/env-load

RUN go get github.com/tsenart/vegeta
RUN go get github.com/raintank/inspect/inspect-idx
RUN go get github.com/raintank/fakemetrics

RUN cd /opt/raintank && \
	git clone https://github.com/raintank/raintank-tsdb-benchmark.git

WORKDIR /opt/raintank/raintank-tsdb-benchmark

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

env PATH /go/src/github.com/raintank/inspect/inspect-idx:/go/src/github.com/raintank/fakemetrics:$PATH

CMD ["/usr/bin/supervisord"]
