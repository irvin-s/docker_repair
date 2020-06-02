FROM golang:1.10 as builder
WORKDIR $GOPATH/src/github.com/PeppyS/what-to-watch/api/

# Install dep
RUN go get -u github.com/golang/dep/...

# Copy code from host and compile
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure --vendor-only
COPY . ./
RUN go build -o /bin/api cmd/api/main.go

# Copy binary to debian and run
FROM debian:jessie-slim
COPY --from=builder /bin/api /bin/api

# Get wait-for-it-script
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/e1f115e4ca285c3c24e847c4dd4be955e0ed51c2/wait-for-it.sh /utils/wait-for-it.sh
RUN chmod 777 /utils/wait-for-it.sh

# Start API when ES is ready
ENTRYPOINT /utils/wait-for-it.sh -t 0 $ELASTICSEARCH_URL -- /bin/api
