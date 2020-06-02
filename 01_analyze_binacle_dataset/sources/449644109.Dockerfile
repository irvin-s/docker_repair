FROM golang:1.11.2
ENV GO111MODULE=on
RUN GO111MODULE=off go get github.com/beego/bee
RUN GO111MODULE=off go get github.com/astaxie/beego
RUN chown www-data:www-data ./

CMD ["bee", "run"]