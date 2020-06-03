FROM quay.io/yldio/paz-base
MAINTAINER Luke Bond "luke@yld.io"

RUN apk --update add bash perl
RUN npm install -g harp

WORKDIR /usr/src/app
ADD ./assets /usr/src/app/assets
ADD ./crossdomain.xml /usr/src/app/crossdomain.xml
ADD ./index.html /usr/src/app/index.html
ADD ./200.jade /usr/src/app/200.jade
ADD ./robots.txt /usr/src/app/robots.txt
ADD ./run.sh /usr/src/app/run.sh

EXPOSE 80

CMD [ "./run.sh" ]
