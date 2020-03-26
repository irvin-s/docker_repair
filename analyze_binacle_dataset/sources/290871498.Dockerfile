FROM golang

RUN mkdir /go/src/hello-kubecon
ADD . /go/src/hello-kubecon
WORKDIR /go/src/hello-kubecon
RUN go build
ARG APP_PORT=8080
ENV APP_PORT=$APP_PORT

ENTRYPOINT ["./hello-kubecon"]
