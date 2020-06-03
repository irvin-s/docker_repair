FROM golang:1.10.1-alpine3.7 as builder

# add tools for debug and development purposes
RUN apk update && \
    apk add --no-cache git gcc musl-dev && \
    apk add glide

ENV SRC_DIR=/go/src/github.com/ashleyschuett/gce-ingress-backend-services/

WORKDIR /app

# Glide install before adding rest of source so we can cache the resulting
# vendor dir
ADD glide.yaml glide.lock $SRC_DIR
RUN cd $SRC_DIR && \
        glide install -v

# Add the source code:
COPY . $SRC_DIR

# Build it:
RUN cd $SRC_DIR && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
        go build -ldflags \
        -a -tags netgo \
        -o gce-ingress-backend-services ./ && \
    cp gce-ingress-backend-services /app/



# Create Docker image of just the binary
FROM scratch as runner
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder ./app/gce-ingress-backend-services .

CMD ["./gce-ingress-backend-services", "-logtostderr=true"]
