FROM golang:1.7

RUN go get github.com/astaxie/beego
RUN go get github.com/beego/bee
RUN go get github.com/satori/go.uuid
RUN go get github.com/smartystreets/goconvey/convey
RUN go get github.com/astaxie/beego/orm
RUN go get github.com/go-sql-driver/mysql

# CMD ["bee", "run"]
