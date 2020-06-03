FROM alpine:latest
MAINTAINER "Shuji Yamada <s-yamada@arukas.io>"
ENV ARUKAS_CLI_VERSION=v0.2.0
ADD https://github.com/arukasio/cli/releases/download/${ARUKAS_CLI_VERSION}/arukas_${ARUKAS_CLI_VERSION}_linux_amd64.zip ./
RUN apk add --update ca-certificates && \
    unzip arukas_${ARUKAS_CLI_VERSION}_linux_amd64.zip && \
    rm -f arukas_${ARUKAS_CLI_VERSION}_linux_amd64.zip

ENTRYPOINT ["/arukas"]
