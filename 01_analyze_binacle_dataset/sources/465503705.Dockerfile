FROM golang:1.10-alpine
RUN apk add --no-cache git && \
  go get github.com/mitchellh/gox
COPY . .
RUN gox -output="/public/{{.Dir}}_{{.OS}}_{{.Arch}}"
