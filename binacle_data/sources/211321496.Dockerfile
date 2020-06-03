FROM golang:1.8-alpine AS build

RUN mkdir -p /go/src/github.com/hairyhenderson/restdemo
WORKDIR /go/src/github.com/hairyhenderson/restdemo
COPY . /go/src/github.com/hairyhenderson/restdemo

RUN go build -ldflags "-w -s"
RUN go build -ldflags "-w -s" -o cli github.com/hairyhenderson/restdemo/tool/restdemo-cli/

FROM alpine:3.6

COPY --from=build /go/src/github.com/hairyhenderson/restdemo/restdemo /app/restdemo
COPY --from=build /go/src/github.com/hairyhenderson/restdemo/cli /app/cli
COPY --from=build /go/src/github.com/hairyhenderson/restdemo/public /app/public

WORKDIR /app
HEALTHCHECK --interval=5s --timeout=5s CMD ./cli show health || exit 1

CMD [ "./restdemo" ]
