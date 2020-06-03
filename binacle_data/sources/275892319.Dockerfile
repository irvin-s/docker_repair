### First stage
FROM golang:1.9

# Add labels
LABEL maintainer="Ferran Rodenas <frodenas@gmail.com>"

# Set environment variables
ENV CGO_ENABLED 0
ENV GOARCH      amd64
ENV GOARM       5
ENV GOOS        linux

# Set the working directory
WORKDIR /go/src/github.com/frodenas/uaa-k8s-oidc-helper/

# Add the application bits
ADD ./ ./

# Build the application
RUN go build -a -installsuffix cgo -o uaa-k8s-oidc-helper .

### Second (and final) stage
FROM alpine:latest

# Add labels
LABEL maintainer="Ferran Rodenas <frodenas@gmail.com>"

# Install CA certificates
RUN apk --no-cache add ca-certificates

# Set the working directory
WORKDIR /root/

# Copy application from 1st stage
COPY --from=0 /go/src/github.com/frodenas/uaa-k8s-oidc-helper/uaa-k8s-oidc-helper .

# Command to run
ENTRYPOINT ["./uaa-k8s-oidc-helper"]
