FROM transpiler/model as model

FROM golang:1.10

ENV GO_PACKAGE github.com/znly/go-ml-transpiler/serving/

COPY . /go/src/${GO_PACKAGE}
WORKDIR /go/src/${GO_PACKAGE}

COPY --from=model /transpiler/model/ server/model/

WORKDIR server

RUN go install

ENTRYPOINT ["server"]

EXPOSE 8080
