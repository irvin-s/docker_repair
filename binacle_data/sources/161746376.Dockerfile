## builder image
FROM cortezaproject/corteza-server-builder:latest AS builder

WORKDIR /go/src/github.com/crusttech/crust-server

COPY . .

RUN scripts/builder-make-bin.sh messaging /tmp/crust-server-messaging

## == target image ==

FROM alpine:3.7

RUN apk add --no-cache ca-certificates

COPY --from=builder /tmp/crust-server-messaging /bin

ENV MESSAGING_STORAGE_PATH /data/messaging

VOLUME /data

EXPOSE 80
ENTRYPOINT ["/bin/crust-server-messaging"]
CMD ["serve-api"]
