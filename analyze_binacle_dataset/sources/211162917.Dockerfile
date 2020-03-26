FROM golang:latest  AS build-env

# Dependencies
WORKDIR /build
ENV GO111MODULE=on
RUN go get github.com/GeertJohan/go.rice/rice
COPY go.mod go.sum ./
RUN go mod download

# Build
COPY . ./
RUN CGO_ENABLED=0 go build -ldflags '-w -s' -o /board
RUN rice append --exec /board

# Build runtime container
FROM alpine
WORKDIR /app
COPY --from=build-env /board /app/board
EXPOSE 8080
CMD ["/app/board"]