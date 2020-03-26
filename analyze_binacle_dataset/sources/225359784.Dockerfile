FROM alpine

ARG JJ_VERSION=1.2.2
RUN apk add --no-cache curl \
 && curl -sL https://github.com/tidwall/jj/releases/download/v${JJ_VERSION}/jj-${JJ_VERSION}-linux-amd64.tar.gz \
  | tar --strip-components=1 -xzf -

ENTRYPOINT [ "/jj" ]
