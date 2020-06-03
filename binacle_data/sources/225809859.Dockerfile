FROM trusty
RUN apt-get update && apt-get install -y build-essential git lxc lxc-dev pkg-config
WORKDIR /opt
RUN wget -q https://storage.googleapis.com/golang/go1.5.2.linux-amd64.tar.gz
RUN tar -zxvf go1.5.2.linux-amd64.tar.gz -C /opt
RUN mkdir /opt/gopath
ENV GOROOT /opt/go
ENV GOPATH /opt/gopath
ENV PATH /opt/go/bin:$PATH
RUN go get github.com/PagerDuty/nut
WORKDIR /opt/gopath/src/github.com/PagerDuty/nut
RUN go get ./... && go install ./...
