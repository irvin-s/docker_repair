FROM golang:1.3.3
MAINTAINER damien.duportal@worldline.com

RUN go get -u github.com/mitchellh/gox
RUN go get -u github.com/schubergphilis/packer-cloudstack
WORKDIR /go/bin
RUN make -C $GOPATH/src/github.com/schubergphilis/packer-cloudstack updatedeps dev \
	&& tar czf /packer-cloudstack-plugin.tgz ./*cloudstack \
	&& rm -f ./*cloudstack
CMD ["cat","/packer-cloudstack-plugin.tgz"]
