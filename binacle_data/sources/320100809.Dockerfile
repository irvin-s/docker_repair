FROM python:2.7-alpine

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

RUN apk --no-cache add --virtual build-dependencies py-pip \
    && apk --no-cache add groff jq \
    && pip install 'awscli == 1.10.67' \
    && apk del --purge -r build-dependencies
                  
VOLUME /root/.aws
              
ENTRYPOINT ["aws"]
CMD ["--version"]
