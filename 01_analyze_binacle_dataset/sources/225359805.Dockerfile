FROM golang:1.9-alpine

WORKDIR /go/src/app
COPY . .

RUN set -eux; \
	apk add --no-cache --virtual git

RUN go-wrapper download \
 && go-wrapper install

FROM alpine:3.7
RUN apk add --update \
        bash \
        ca-certificates \
        tzdata


COPY --from=0 /go/bin/app /app
CMD ["/app"]
