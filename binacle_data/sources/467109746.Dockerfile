FROM golang:latest
ENV GO111MODULE=on
RUN mkdir -p $GOPATH/src/github.com/dd3v/snippets-page-backend
WORKDIR $GOPATH/src/github.com/dd3v/snippets-page-backend
COPY .  $GOPATH/src/github.com/dd3v/snippets-page-backend
RUN go mod download
RUN go build -o /snippets-page main.go
CMD /snippets-page