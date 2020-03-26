# Stage 1: Build the application
FROM golang:1.12-alpine as builder

RUN apk add -U --no-cache build-base git

RUN mkdir /build
RUN mkdir /seabird
WORKDIR /seabird

ADD . .

RUN go get -d ./... && \
        go build -v -o /build/seabird ./cmd/seabird && \
        go build -v -o /build/seabird-migrate ./cmd/seabird-migrate

# Stage 2: Copy files and configure what we need
FROM alpine:latest

# Add runtime dependencies
RUN apk add -U --no-cache iputils ca-certificates

# Copy the built seabird into the container
COPY --from=builder /build /bin

VOLUME /data
ENV SEABIRD_CONFIG /data/seabird.toml

ENTRYPOINT ["/bin/seabird"]
