FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y wget gcc make g++ build-essential ca-certificates mercurial git bzr libsqlite3-dev sqlite3 git

RUN wget https://go.googlecode.com/files/go1.2.src.tar.gz && tar zxvf go1.2.src.tar.gz && cd go/src && ./make.bash
ENV PATH $PATH:/go/bin:/gocode/bin
ENV GOPATH /gocode
RUN go get github.com/tools/godep

RUN mkdir -p /gocode/src/github.com/drone
RUN git clone https://github.com/aluzzardi/drone.git /gocode/src/github.com/drone/drone
WORKDIR /gocode/src/github.com/drone/drone

# There is no way to set the api path in the current version. Reported bug https://github.com/drone/drone/issues/473
# but currently this works as a workaround. Probably fixed in the new version.
RUN sed 's@apiPath: "/api/v3"@apiPath: "/git/api/v3"@' -i pkg/handler/gitlab.go

RUN godep restore && make && make install

VOLUME /var/lib/drone
CMD ["/usr/local/bin/droned", "--port=:80", "--datasource=/var/lib/drone/drone.sqlite"]
EXPOSE 80
