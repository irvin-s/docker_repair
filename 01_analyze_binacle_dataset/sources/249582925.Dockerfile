FROM golang:1.10-alpine as builder
ADD main.go /go/src/goapp/
RUN cd /go/src/goapp/ && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM scratch
COPY --from=builder /go/src/goapp/main /
# ENTRYPOINT ["/main"]
CMD ["/main"]