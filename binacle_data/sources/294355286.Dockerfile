FROM funcy/go:dev
RUN go get -u github.com/golang/dep/cmd/dep
RUN mkdir -p $GOPATH/src/github.com/denismakogon/tweet-success
ADD . $GOPATH/src/github.com/denismakogon/tweet-success
WORKDIR $GOPATH/src/github.com/denismakogon/tweet-success
RUN $GOPATH/bin/dep ensure -v
RUN go build -o func
ENTRYPOINT ["./func"]
