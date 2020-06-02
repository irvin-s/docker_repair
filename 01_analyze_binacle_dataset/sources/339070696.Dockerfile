# Build using Dep
FROM golang:1.10.6 as builder
RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 && chmod +x /usr/local/bin/dep

# Get dependencies first for docker caching
WORKDIR /go/src/github.com/eug48/fhir/
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure --vendor-only -v

# Copy source
COPY . ./

# Build
WORKDIR /go/src/github.com/eug48/fhir/fhir-server
RUN go build -ldflags "-X main.gitCommit=$GIT_COMMIT"

# Copy into official image with MongoDB
FROM mongo:4-xenial
COPY --from=builder /go/src/github.com/eug48/fhir/fhir-server/fhir-server /
COPY --from=builder /go/src/github.com/eug48/fhir/fhir-server/config/ /config
COPY --from=builder /go/src/github.com/eug48/fhir/conformance/ /conformance
CMD ["/fhir-server", "--startMongod", "--mongodbURI", "mongodb://localhost:27017/?replicaSet=rs0", "--port", "3001", "--enableXML", "--disableSearchTotals"]