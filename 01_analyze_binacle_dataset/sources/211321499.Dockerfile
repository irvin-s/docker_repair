FROM golang:1.8-alpine

RUN mkdir -p /go/src/github.com/hairyhenderson/restdemo
WORKDIR /go/src/github.com/hairyhenderson/restdemo
COPY . /go/src/github.com/hairyhenderson/restdemo

# build the service
RUN go build -ldflags "-w -s"

RUN apk --no-cache add curl

HEALTHCHECK --interval=5s --timeout=5s \
  CMD curl --fail http://localhost:8000/health || exit 1

CMD [ "/go/src/github.com/hairyhenderson/restdemo/restdemo" ]
