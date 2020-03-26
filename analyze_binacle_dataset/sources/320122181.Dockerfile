FROM golang:1.10 as builder
WORKDIR $GOPATH/src/github.com/PeppyS/what-to-watch/scraper/

# Install dep
RUN go get -u github.com/golang/dep/...

# Copy code from host and compile
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure --vendor-only
COPY . ./
RUN go build -o /bin/scraper cmd/scraper/main.go

# Copy binary to debian and run
FROM debian:jessie-slim

# Need ca-certificates to make https requests from container
RUN apt-get update
RUN apt-get install -y ca-certificates

# Get wait-for-it-script
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/e1f115e4ca285c3c24e847c4dd4be955e0ed51c2/wait-for-it.sh /utils/wait-for-it.sh
RUN chmod 777 /utils/wait-for-it.sh

COPY --from=builder /bin/scraper /bin/scraper

# Start scraper when API is ready
ENTRYPOINT /utils/wait-for-it.sh -t 0 $API_URL -- /bin/scraper
