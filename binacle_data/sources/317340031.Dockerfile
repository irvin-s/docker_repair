FROM registry.cn-hangzhou.aliyuncs.com/choerodon-tools/golang:1.9.4-alpine3.7 as builder
WORKDIR /go/src/github.com/choerodon/go-register-server
COPY . .
RUN go build .

FROM registry.cn-hangzhou.aliyuncs.com/choerodon-tools/alpine:c7n
WORKDIR /
COPY --from=builder /go/src/github.com/choerodon/go-register-server/go-register-server .
COPY --from=builder /go/src/github.com/choerodon/go-register-server/templates /templates
COPY --from=builder /go/src/github.com/choerodon/go-register-server/static /static
CMD ["/go-register-server"]
