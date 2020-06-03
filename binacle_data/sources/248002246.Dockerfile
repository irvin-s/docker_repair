FROM xzdbd/golang:alpine

MAINTAINER xzdbd <xzdbd@sina.com>

VOLUME /go/bin/static

RUN set -ex \
		apk update && apk upgrade \
    	&& apk add --no-cache bash git openssh \
		&& go get -u github.com/xzdbd/static-host \
		&& cp -rf /go/src/github.com/xzdbd/static-host/conf /go/bin/ \
		&& cp -rf /go/src/github.com/xzdbd/static-host/views /go/bin/

EXPOSE 8180

WORKDIR /go/bin

CMD /go/bin/static-host