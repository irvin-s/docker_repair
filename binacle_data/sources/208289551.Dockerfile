FROM busybox:ubuntu-14.04

MAINTAINER tsaikd <tsaikd@gmail.com>

ENV GO_RAML_MOCKER_VERSION 1.0.3

ADD https://github.com/tsaikd/go-raml-mocker/releases/download/${GO_RAML_MOCKER_VERSION}/go-raml-mocker-Linux-x86_64 /usr/local/bin/go-raml-mocker

RUN chmod +x /usr/local/bin/go-raml-mocker

CMD ["go-raml-mocker"]
