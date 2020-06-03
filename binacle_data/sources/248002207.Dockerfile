FROM golang:1.6.3

MAINTAINER xzdbd <xzdbd@sina.com>

RUN apt-get update \
	&& apt-get install -y ruby-full \
	&& apt-get install -y nodejs && apt-get install -y npm

RUN set -ex \
		&& echo "Asia/Shanghai" > /etc/timezone \
		&& dpkg-reconfigure -f noninteractive tzdata \
		&& apt-get install -y git-all \
		&& go get -u github.com/xzdbd/blog \
		&& cd /go/src/github.com/xzdbd/blog/views/octopress \
		&& gem install bundler && bundle install && rake generate

RUN cp -rf /go/src/github.com/xzdbd/blog/conf /go/bin/ \
	&& cp -rf /go/src/github.com/xzdbd/blog/static /go/bin/ \
	&& mkdir -p /go/bin/views/octopress \
	&& mkdir -p /go/bin/logs \
	&& cp -rf /go/src/github.com/xzdbd/blog/views/octopress/public /go/bin/views/octopress \
	&& cp -rf /go/src/github.com/xzdbd/blog/views/resume.tpl /go/bin/views/

EXPOSE 8096

WORKDIR /go/bin

CMD /go/bin/blog