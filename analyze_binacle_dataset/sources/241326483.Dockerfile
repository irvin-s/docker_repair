# AWS-CLI v1.15
# docker run --rm supinf/awscli:1.15 --version
# docker run --rm -v $HOME/.aws:/root/.aws supinf/awscli:1.15 sts get-caller-identity

FROM alpine:3.8

ENV PAGER=less \
    LESS="-eirMX"

RUN apk --no-cache add python3 less
RUN apk --no-cache add --virtual build-dependencies py3-pip \
      && apk --no-cache add groff jq \
      && pip3 install 'awscli == 1.15.85' \
      && apk del --purge -r build-dependencies

ENTRYPOINT ["aws"]
CMD ["--version"]
