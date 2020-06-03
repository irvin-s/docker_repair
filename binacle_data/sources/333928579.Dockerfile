FROM golang:1.9-alpine as builder

# Install dependencies
RUN apk add --update --no-cache ca-certificates

# Build
WORKDIR /go/src/github.com/monostream/k8s-localflex-provisioner/driver

COPY . .
RUN GOOS=linux GOOARCH=amd64 CGO_ENABLE=0 go build -o localflex .

# Copy artefacts
WORKDIR /app/
RUN cp /go/src/github.com/monostream/k8s-localflex-provisioner/driver/localflex .
RUN rm -r /go/src/

FROM busybox

WORKDIR /app/

COPY scripts/deploy.sh .
COPY --from=builder /app/ .

# Setup environment
ENV PATH "/app:${PATH}"

CMD ["deploy.sh"]