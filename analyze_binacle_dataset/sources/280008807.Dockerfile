FROM golang:1.8 as build-stage
ENV APP /go/src/github.com/infoslack/blockchain
ADD . $APP/
WORKDIR $APP/cmd
RUN go get && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o blockchain .

FROM scratch
COPY --from=build-stage /go/src/github.com/infoslack/blockchain/cmd/blockchain /blockchain
CMD ["/blockchain"]
