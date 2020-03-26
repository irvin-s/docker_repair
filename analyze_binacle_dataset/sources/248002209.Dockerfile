FROM xzdbd/golang:alpine

MAINTAINER xzdbd <xzdbd@sina.com>

RUN set -ex \
		apk update && apk upgrade \
    	&& apk add --no-cache bash git openssh \
		&& go get -u github.com/xzdbd/box \
		&& cp -rf /go/src/github.com/xzdbd/box/conf /go/bin/ \
		&& cp -rf /go/src/github.com/xzdbd/box/static /go/bin/ \
		&& cp -rf /go/src/github.com/xzdbd/box/views /go/bin/ \
		&& mkdir -p /go/bin/logs

EXPOSE 8097

WORKDIR /go/bin

CMD /go/bin/box