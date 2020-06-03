FROM alpine:3.5

ARG V=bad

ADD dist/soil-$V-linux-amd64.tar.gz /usr/bin/

EXPOSE 7654

ADD testdata/integration/permanent.hcl /opt/permanent.hcl