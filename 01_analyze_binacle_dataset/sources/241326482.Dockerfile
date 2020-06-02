# AWS CLI v1.14

FROM alpine:3.7

ENV PAGER=less \
    LESS="-eirMX"

RUN apk --no-cache add python less
RUN apk --no-cache add --virtual build-dependencies py2-pip \
      && apk --no-cache add groff jq \
      && pip install 'awscli == 1.14.70' \
      && apk del --purge -r build-dependencies

ENTRYPOINT ["aws"]
CMD ["--version"]
