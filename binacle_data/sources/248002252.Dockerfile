FROM xzdbd/golang:alpine

MAINTAINER xzdbd <xzdbd@sina.com>

RUN set -ex \
		apk update && apk upgrade && \
    	apk add --no-cache bash git openssh \
		&& go get -u github.com/astaxie/beego \
		&& go get -u github.com/xzdbd/weixingis \
		&& cp -rf /go/src/github.com/xzdbd/weixingis/conf /go/bin/

EXPOSE 8092

WORKDIR /go/bin

CMD /go/bin/weixingis