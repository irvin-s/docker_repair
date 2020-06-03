FROM golang:alpine AS build

COPY . /go/src/github.com/kavehmz/jobber
WORKDIR /go/src/github.com/kavehmz/jobber
RUN go build -o /bin/jobber example/lambda/main.go

# This results in a single layer image
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=build /bin/jobber /bin/jobber
EXPOSE 50051
ENTRYPOINT ["/bin/jobber"]
