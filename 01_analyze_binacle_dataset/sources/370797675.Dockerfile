# Builder image, where we build the example.
FROM golang:1.10-alpine3.7 AS builder

# Dependencies for build
RUN apk --no-cache add make

WORKDIR /go/src/github.com/astoliarov/jackal
COPY . .
RUN make build


# Final image.
FROM alpine

RUN apk --no-cache add bash ca-certificates tzdata
ENV TZ Europe/Minsk

WORKDIR "/jackal"
COPY --from=builder /go/src/github.com/astoliarov/jackal/bin/api .
CMD ["/jackal/api"]
