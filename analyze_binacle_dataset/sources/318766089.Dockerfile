FROM golang:alpine
RUN mkdir /app 
ENV GOPATH /go/
ENV APP_PATH $GOPATH/src/github.com/robszumski/prometheus-replica-operator
ADD . $APP_PATH
WORKDIR $APP_PATH 
RUN go build -o /usr/local/bin/prometheus-replica-operator github.com/robszumski/prometheus-replica-operator/cmd/prometheus-replica-operator
RUN adduser -S -D -H -h $APP_PATH prometheus-operator
USER prometheus-operator
CMD ["prometheus-replica-operator"]
