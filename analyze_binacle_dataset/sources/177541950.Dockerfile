FROM raintank/nodejsgo

ENV GOPATH /go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin
RUN go get -u github.com/vimeo/statsdaemon/statsdaemon

COPY conf/statsdaemon.ini /etc/statsdaemon.ini

ENTRYPOINT ["/go/bin/statsdaemon"]
