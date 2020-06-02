FROM ubuntu:14.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl git mercurial make binutils bison gcc build-essential golang

# Set GOPATH/GOROOT environment variables
RUN mkdir -p /go
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

# Set up app
ADD . /app
RUN cd /app && go build hello.go

# Removed unnecessary packages
RUN apt-get autoremove -y

# Clear package repository cache
RUN apt-get clean all

EXPOSE 8080
CMD ["/app/hello"]
