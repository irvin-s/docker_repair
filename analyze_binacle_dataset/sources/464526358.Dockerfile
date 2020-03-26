FROM alpine:latest

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh-client ca-certificates

ADD dist/newsbot /bin/newsbot

RUN adduser -D -g '' astrocorp

USER astrocorp

WORKDIR /newsbot

CMD ["newsbot"]
