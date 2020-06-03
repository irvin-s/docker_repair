FROM golang as build

WORKDIR /go/src/github.com/vbatts/imgsrv
COPY . .
RUN go install -tags netgo github.com/vbatts/imgsrv

FROM busybox as prod
ENV MONGODB_DATABASE filesrv
ENV MONGODB_SERVICE_HOST 127.0.0.1
ENV MONGODB_SERVICE_PORT 27017
EXPOSE 7777
COPY --from=build /go/bin/imgsrv /usr/local/bin/imgsrv
COPY --from=build /go/src/github.com/vbatts/imgsrv/run.sh /usr/local/bin/run.sh
ENTRYPOINT ["/bin/sh", "/usr/local/bin/run.sh"]
