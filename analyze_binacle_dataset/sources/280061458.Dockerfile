FROM golang:1.9.1

RUN go get -u \
        github.com/kardianos/govendor \
        github.com/golang/lint/golint \
        github.com/golang/mock/mockgen \
        github.com/smartystreets/goconvey
