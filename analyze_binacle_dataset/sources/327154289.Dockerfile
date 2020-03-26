##
## Build Stage
##
FROM golang:alpine AS build

ARG SRC_ROOT
ENV SRC_ROOT=${SRC_ROOT}

WORKDIR /go/src/${SRC_ROOT}/
COPY ./ /go/src/${SRC_ROOT}/
RUN ./.BUILD.sh

##
## Production Stage
##
FROM alpine as production
RUN apk --no-cache add ca-certificates

ARG SRC_ROOT
ENV SRC_ROOT=${SRC_ROOT}

# copy binary
COPY --from=build /go/src/$SRC_ROOT/bin/server /app/
# copy asset files
COPY --from=build /go/src/$SRC_ROOT/asset /app/asset/

EXPOSE 30001

RUN addgroup -g 1000 -S go && \
    adduser -u 1000 -S go -G go
RUN chown -R go:go /app
USER go

ENTRYPOINT /app/server

