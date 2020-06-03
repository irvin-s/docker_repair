FROM raintank/nodejsgo

ENV GOPATH /go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin
RUN go get github.com/raintank/eventtank
RUN mkdir /etc/raintank
COPY eventtank.ini /etc/raintank/eventtank.ini
COPY start.sh /start.sh
ENTRYPOINT ["/start.sh"]
CMD ["-config", "/etc/raintank/eventtank.ini"]
