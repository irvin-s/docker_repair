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
RUN cd cmd/whatsapptistics && CGO_ENABLED=0 go build -o ../../server
############################
# STEP 2 certs a small image
############################
FROM scratch
#FROM alpine

# import certs
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd

# Copy our static executable and template files
COPY --from=builder /whatsapptistics/server /whatsapptistics/server
COPY --from=builder /whatsapptistics/web /whatsapptistics/web
# copy dotenv file
COPY .env /whatsapptistics/.env
# Run the binary.
WORKDIR "/whatsapptistics"
ENTRYPOINT ["/whatsapptistics/server"]
EXPOSE 8000
