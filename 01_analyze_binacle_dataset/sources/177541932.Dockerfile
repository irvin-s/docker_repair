FROM raintank/nodejsgo

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV GOPATH /go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin
RUN go get -u github.com/raintank/inspect/graphitewatcher

CMD ["/usr/bin/supervisord"]
