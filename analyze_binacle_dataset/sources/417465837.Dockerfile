FROM alpine:latest

ENV ENVIRONMENT=dev
ENV AWS_DEFAULT_REGION=eu-west-1
ENV AWS_REGION=eu-west-1

RUN apk --update --no-cache add \
  ca-certificates \
  py-pip \
  && pip install awscli

VOLUME [ "/target" ]
