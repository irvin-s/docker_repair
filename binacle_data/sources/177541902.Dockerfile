FROM raintank/nodejsgo

ENV GOPATH /go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin
RUN mkdir -p /var/spool/carbon-relay-ng

WORKDIR /
ADD proxy.ini /proxy.ini
ADD storage-schemas.conf /storage-schemas.conf
CMD /go/src/github.com/graphite-ng/carbon-relay-ng/carbon-relay-ng -mem-profile-rate 10240 proxy.ini
