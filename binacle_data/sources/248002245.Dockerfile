FROM golang:1.8

MAINTAINER xzdbd <xzdbd@sina.com>

VOLUME /go/bin/conf

RUN set -ex \
	&& echo "Asia/Shanghai" > /etc/timezone \
	&& dpkg-reconfigure -f noninteractive tzdata \
	&& apt-get update \
	&& apt-get install -y git-all \
	&& go get -u github.com/xzdbd/squeak

RUN cp -rf /go/src/github.com/xzdbd/squeak/conf /go/bin/ \
	&& cp -rf /go/src/github.com/xzdbd/squeak/static /go/bin/ \
	&& cp -rf /go/src/github.com/xzdbd/squeak/views /go/bin/

EXPOSE 8094

WORKDIR /go/bin

CMD /go/bin/squeak