FROM centos
RUN yum install golang golang-godoc golang-vet golang-src golang-pkg-linux-amd64 -y
RUN mkdir /app
ENV GOPATH /go/
ENV APP_PATH $GOPATH/src/github.com/robszumski/prometheus-replica-operator
ADD . $APP_PATH
WORKDIR $APP_PATH 
RUN go build -o /usr/local/bin/prometheus-replica-operator github.com/robszumski/prometheus-replica-operator/cmd/prometheus-replica-operator
RUN adduser prometheus-operator
USER prometheus-operator
CMD ["prometheus-replica-operator"]
