FROM golang:alpine
COPY helloworld.go /
RUN go build -o /helloworld /helloworld.go
ENTRYPOINT [ "/helloworld" ]
