FROM xzdbd/golang:alpine

MAINTAINER xzdbd <xzdbd@sina.com>

RUN set -ex \
		apk update && apk upgrade && \
    	apk add --no-cache bash git openssh \
		&& go get -u github.com/xzdbd/ops-angel \
		&& cp -rf /go/src/github.com/xzdbd/ops-angel/conf /go/bin/ \
		&& cp -rf /go/src/github.com/xzdbd/ops-angel/views /go/bin/

EXPOSE 8099

WORKDIR /go/bin

CMD /go/bin/ops-angel