# AWS CLI v1.11

FROM alpine:3.6

ENV PAGER=less \
    LESS="-eirMX"

RUN apk --no-cache add python less
RUN apk --no-cache add --virtual build-dependencies py2-pip \
      && apk --no-cache add groff jq \
      && pip install 'awscli == 1.11.190' \
      && apk del --purge -r build-dependencies

ENTRYPOINT ["aws"]
CMD ["--version"]
