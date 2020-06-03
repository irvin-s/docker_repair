FROM golang
MAINTAINER clarkzjw <clarkzjw@gmail.com>

RUN \
  go get gopkg.in/mgo.v2 && \
  git clone https://github.com/sakeven/restweb.git $GOPATH/src/restweb && \
  cd $GOPATH/src/restweb && \
  go install ./...

CMD ["bash"]
