FROM alpine:latest

ENV COW_INSTALLDIR /usr/local/bin

VOLUME /root/.cow/

RUN set -ex \
	apk update && apk upgrade && \
    apk add --no-cache bash git openssh curl &&\
	curl -L git.io/cow | bash &&\
    chmod u+x $COW_INSTALLDIR/cow

CMD $COW_INSTALLDIR/cow
