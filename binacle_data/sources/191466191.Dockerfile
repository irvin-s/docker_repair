# building linux-amd64 native binary via Dockerized Go compiler
#
# @see https://registry.hub.docker.com/_/golang/
#

# pull base image
FROM golang:1.4.2
MAINTAINER William Yeh <william.pjyeh@gmail.com>

ENV EXE_NAME         extract-elf-so_linux-amd64
ENV EXE_STATIC_NAME  extract-elf-so_static_linux-amd64
ENV GOPATH    /opt 
WORKDIR       /opt


# fetch imported Go lib...
RUN  go get github.com/docopt/docopt-go
COPY extract-elf-so.go /opt/

# compile...
RUN  go build -o $EXE_NAME

#-- 
#    @see Static build method changed in Go 1.4
#         https://github.com/kelseyhightower/rocket-talk/issues/1
#--
RUN  CGO_ENABLED=0  \
     go build -x -a -installsuffix nocgo \
              -o $EXE_STATIC_NAME


# copy executable
RUN    mkdir -p /dist
VOLUME [ "/dist" ]
CMD    cp  *_linux-amd64  /dist
