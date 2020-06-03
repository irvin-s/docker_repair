# package the oshinko-rest app into a container
# by default this image will run the server listening on port 8080
FROM centos:latest

RUN yum -y install make golang git && yum clean all

ADD . /go/src/github.com/radanalyticsio/oshinko-cli

ENV GOPATH /go
WORKDIR /go/src/github.com/radanalyticsio/oshinko-cli/rest
RUN make install

RUN chmod a+rwX -R .

CMD /go/src/github.com/radanalyticsio/oshinko-cli/rest/tools/start_server.sh
