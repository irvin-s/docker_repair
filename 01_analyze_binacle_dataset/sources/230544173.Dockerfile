FROM golang:wheezy

ENV DIST /go/src/github.com/k8sp/graphviz

RUN apt-get update
RUN apt-get install -y graphviz

COPY . $DIST
RUN cd $DIST && go get ./... && go get .

EXPOSE 9090
VOLUME ["/cache"]
ENTRYPOINT ["graphviz"]
CMD ["-addr=:9090", "-dir=/cache"]
