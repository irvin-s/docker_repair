FROM raintank/nodejsgo

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV GOPATH /go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin
RUN go get -u github.com/Dieterbe/linecounter
RUN go get -u github.com/raintank/inspect/nsq_metrics_to_stdout

CMD ["/usr/bin/supervisord"]
