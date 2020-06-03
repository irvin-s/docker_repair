FROM golang:latest as builder

### install needed packages
RUN go get github.com/kataras/iris
RUN go get gopkg.in/mgo.v2/bson

RUN mkdir /go/src/voting
ADD . /go/src/voting
WORKDIR /go/src/voting
RUN CGO_ENABLED=0 GOOS=linux go build -tags static app.go

FROM alpine:3.6
COPY --from=builder /go/src/voting/app .
ENV PORT 8080
EXPOSE 8080
CMD ["/app"]