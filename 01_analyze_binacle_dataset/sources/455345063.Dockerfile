FROM alpine

MAINTAINER Trevor Hartman <trevorhartman@gmail.com>

RUN apk --update add curl bash

ADD run.sh /run.sh

CMD /run.sh
