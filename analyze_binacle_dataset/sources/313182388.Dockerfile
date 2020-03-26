FROM alpine

COPY ProxyGrabber .
COPY ./template/api /template/api
COPY ./template/contact /template/contact
COPY ./template/index /template/index
COPY ./template/static /template/static

RUN apk update && apk add --no-cache ca-certificates nano

ENTRYPOINT [ "./ProxyGrabber" ]