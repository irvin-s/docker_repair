FROM golang:1.9 AS builder
WORKDIR /go/src/github.com/phoracek/kubetron/
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
COPY . .
RUN dep ensure --vendor-only
RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/kubetron-admission github.com/phoracek/kubetron/cmd/admission

FROM alpine
COPY --from=builder /bin/kubetron-admission /bin/kubetron-admission
ENTRYPOINT ["/bin/kubetron-admission"]
