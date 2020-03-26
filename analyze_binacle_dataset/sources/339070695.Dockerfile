# Old build using go get:
# COPY . /go/src/github.com/eug48/fhir/
# RUN ls -l /go/src/github.com/eug48/fhir/
# WORKDIR /
# RUN go get -d -v github.com/eug48/fhir/fhir-server
# WORKDIR /go/src/github.com/eug48/fhir/fhir-server
# RUN CGO_ENABLED=0 GOOS=linux go build

# Build using Dep
FROM golang:1.10.6-alpine as builder
RUN apk add --no-cache ca-certificates curl git build-base
RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64 && chmod +x /usr/local/bin/dep

# Get dependencies first for docker caching
WORKDIR /go/src/github.com/eug48/fhir/
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure --vendor-only -v

# Copy source
COPY . ./

# Build
WORKDIR /go/src/github.com/eug48/fhir/fhir-server
ARG GIT_COMMIT=dev
RUN go build -ldflags "-X main.gitCommit=$GIT_COMMIT"

# Copy to light-weight runtime image
FROM alpine:3.7
RUN apk add --no-cache ca-certificates tini
COPY --from=builder /go/src/github.com/eug48/fhir/fhir-server/fhir-server /
COPY --from=builder /go/src/github.com/eug48/fhir/fhir-server/config/ /config
COPY --from=builder /go/src/github.com/eug48/fhir/conformance/ /conformance

ENV MONGODB_URI mongodb://fhir-mongo:27017/?replicaSet=rs0
CMD ["sh", "-c", "/fhir-server -port 3001 -disableSearchTotals -enableXML -databaseName fhir -mongodbURI $MONGODB_URI"]