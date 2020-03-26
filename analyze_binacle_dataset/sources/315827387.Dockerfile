FROM golang:latest AS golang
WORKDIR /go/src/github.com/cisco-sso/mh
RUN go get -u github.com/golang/dep/cmd/dep
COPY . .
RUN dep ensure \
&& CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o mh .

FROM dtzar/helm-kubectl:2.9.1
WORKDIR /root/
COPY --from=golang /go/src/github.com/cisco-sso/mh/mh .
ENTRYPOINT ["./mh"]
