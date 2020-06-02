FROM gliderlabs/alpine:3.1

COPY . /go/src/github.com/Topface/diplodocus

RUN apk-install go git && \
    GOPATH=/go go get github.com/Topface/diplodocus/cmd/diplodocus-server && \
    mv /go/bin/diplodocus-server /bin/diplodocus-server && \
    rm -rf /go && \
    apk del go git

VOLUME ["/var/log/diplodocus"]

EXPOSE 8000

ENTRYPOINT ["/bin/diplodocus-server", "-root", "/var/log/diplodocus", "-listen", ":8000"]
