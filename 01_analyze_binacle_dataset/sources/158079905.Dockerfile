FROM golang:onbuild
MAINTAINER Utkarsh Mani Tripathi <utkarshmani1997@gmail.com>
ADD . /home
WORKDIR /home
RUN go get github.com/prometheus/client_golang/prometheus
RUN ["go","build"]
ENTRYPOINT ["./home"]
EXPOSE 8080
