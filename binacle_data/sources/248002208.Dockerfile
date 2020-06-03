FROM golang:1.6.3

MAINTAINER xzdbd <xzdbd@sina.com>
  
ENV LC_ALL C.UTF-8

RUN apt-get update \
	&& apt-get install -y ruby-full \
	&& apt-get install -y nodejs && apt-get install -y npm

RUN set -ex \
		&& apt-get install -y git-all \
		&& go get -u github.com/astaxie/beego \
		&& go get -u github.com/beego/bee \
		&& go get -u github.com/xzdbd/blog

RUN cd /go/src/github.com/xzdbd/blog/views/octopress \
	&& gem install bundler && bundle install && rake generate

EXPOSE 8096

WORKDIR /go/src/github.com/xzdbd/blog

CMD /bin/bash