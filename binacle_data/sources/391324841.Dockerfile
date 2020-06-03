# Start from golang v1.12 base image
FROM golang:1.12 as builder

# Set the Current Working Directory inside the container
WORKDIR /temp

COPY go.mod .
COPY go.sum .
RUN go get

# Copy everything from the current directory to the PWD(Present Working Directory) inside the container
COPY . .

# * CGO_ENABLED=0 to build a statically-linked executable
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app .


######## Start a new stage from scratch #######
FROM scratch

# set working directory
WORKDIR /app

# copy the binary from builder
COPY --from=builder /app .

# This container exposes port 8080 to the outside world
EXPOSE 3000

# Run the executable
ENTRYPOINT ["./app"]
CMD []
