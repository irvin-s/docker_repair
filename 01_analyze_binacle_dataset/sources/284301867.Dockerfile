FROM golang:1.9 as builder
COPY * /go/src/{{.FunctionName}}/
RUN go get -d -v {{.FunctionName}}
RUN cd /go/src/{{.FunctionName}} && CGO_ENABLED=0 go build -v -a -ldflags '-extldflags "-static"' .

FROM alpine
COPY --from=builder /go/src/{{.FunctionName}}/{{.FunctionName}} /bin/{{.FunctionName}}
CMD ["/bin/{{.FunctionName}}"]
