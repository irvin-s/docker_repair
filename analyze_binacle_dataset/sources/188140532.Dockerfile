FROM golang:1.11.2

ENV CGO_ENABLED=0

WORKDIR /sources/crashdump

CMD ["go", "build"]