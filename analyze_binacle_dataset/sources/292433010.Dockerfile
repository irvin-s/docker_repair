FROM golang as builder

COPY main.go /go/src/fn/
RUN CGO_ENABLED=0 GOOS=linux go install -a -ldflags '-extldflags "-static"' fn

FROM alpine
COPY --from=builder /go/bin/fn /bin/fn

CMD ["/bin/fn"]
