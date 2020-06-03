FROM gcr.io/cloud-builders/go as builder

ENV CGO_ENABLED 0
ENV PKG /root/go/src/github.com/eoscanada/eos-blocksigner
RUN mkdir -p $PKG
COPY . $PKG
RUN cd $PKG \
    && go test -v ./... \
    && go build -v -o /eos-blocksigner



# Final image
FROM alpine:3.8
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
COPY --from=builder /eos-blocksigner /app/eos-blocksigner
