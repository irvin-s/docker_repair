FROM ubuntu:16.04

LABEL maintainer="John Jacquay <jjacquay712@gmail.com>"

ENV GOINSTALL /usr/local/go
ENV GOPATH /go
ENV PATH $PATH:$GOINSTALL/bin:$GOPATH/bin
ENV CGO_LDFLAGS_ALLOW .*

WORKDIR /go

RUN apt-get update
RUN apt-get install -y wget git build-essential

# Install Go
RUN wget https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.10.2.linux-amd64.tar.gz
RUN rm -rf go1.10.2.linux-amd64.tar.gz

# Install iRODS + GoRODS
RUN apt-get install -y lsb-release apt-transport-https libxml2
RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add -
RUN echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/renci-irods.list
RUN apt-get update
RUN apt-get install -y irods-externals* irods-runtime irods-dev libssl-dev
RUN mkdir -p /go/src/github.com/jjacquay712/GoRODS
COPY . /go/src/github.com/jjacquay712/GoRODS

ENTRYPOINT ["/usr/local/go/bin/go", "test", "-test.v", "github.com/jjacquay712/GoRODS"]
