FROM golang:1.9-alpine as builder

# Install dependencies
RUN apk add --update --no-cache ca-certificates wget

# Build
WORKDIR /go/src/github.com/monostream/k8s-localflex-provisioner/provisioner

COPY . .
RUN CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o localflex-provisioner .

# Copy artefacts
WORKDIR /app/
RUN cp /go/src/github.com/monostream/k8s-localflex-provisioner/provisioner/localflex-provisioner .
RUN rm -r /go/src/

# Download dumb-init 1.2.1
RUN wget -nv -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && chmod 755 /usr/local/bin/dumb-init

FROM scratch

WORKDIR /app/

COPY --from=builder /app/ .
COPY --from=builder /usr/local/bin/dumb-init /usr/local/bin/dumb-init

# Setup environment
ENV PATH "/app:${PATH}"

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD ["localflex-provisioner"]