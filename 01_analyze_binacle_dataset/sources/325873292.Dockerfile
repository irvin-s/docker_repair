############################
# STEP 1 certs executable binary
############################
FROM golang:alpine AS builder
# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git ca-certificates
COPY . /whatsapptistics
WORKDIR /whatsapptistics
# Fetch dependencies.
# Using go get.
#RUN go get -d -v
RUN go mod download
# Build the binary.
RUN cd cmd/whatsapptistics-consumer && CGO_ENABLED=0 go build -o ../../analyzer-service
############################
# STEP 2 certs a small image
############################
FROM scratch

# import certs
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd

# Copy our static executable and template files
COPY --from=builder /whatsapptistics/analyzer-service /whatsapptistics/analyzer-service
COPY --from=builder /whatsapptistics/web /whatsapptistics/web
# copy dotenv file
COPY .env /whatsapptistics/.env
# Run the binary.
WORKDIR "/whatsapptistics"
ENTRYPOINT ["/whatsapptistics/analyzer-service"]
