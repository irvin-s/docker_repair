FROM node:10.14-alpine as base
ARG GOLANG_VERSION=1.12.1
ARG GOLANG_SRC_URL=https://dl.google.com/go/go${GOLANG_VERSION}.src.tar.gz
ARG GOLANG_SRC_SHA256=0be127684df4b842a64e58093154f9d15422f1405f1fcff4b2c36ffc6a15818a
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN set -ex \
  && apk add --no-cache --virtual .build-deps \
    bash \
    gcc \
    musl-dev \
    openssl \
    go \
  \
  && export GOROOT_BOOTSTRAP="$(go env GOROOT)" \
  \
  && wget -q "$GOLANG_SRC_URL" -O golang.tar.gz \
  && echo "$GOLANG_SRC_SHA256  golang.tar.gz" | sha256sum -c - \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz \
  && cd /usr/local/go/src \
  && ./make.bash \
  \
  && apk del .build-deps

RUN apk --no-cache add curl git bash
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH" && \
  npm install -g yarn


FROM base AS builder
ARG CLI_VERSION="undefined"
ARG CORE_VERSION="undefined"
ENV GO111MODULE on
ENV FLOGO_LIB_VERSION ${CORE_VERSION}
ENV BUILD_DIR /tmp/build
ENV FLOGO_WEB_LOCALDIR ${BUILD_DIR}/dist/local
RUN go get -u github.com/project-flogo/cli/cmd/flogo@${CLI_VERSION} \
    && mkdir -p $GOPATH/src/github.com/project-flogo \
    && cd $GOPATH/src/github.com/project-flogo \
    && git clone https://github.com/project-flogo/cli.git \
    && flogo --version

COPY / ${BUILD_DIR}/
WORKDIR ${BUILD_DIR}
RUN yarn --pure-lockfile && yarn release && \
  cd dist/apps/server && \
  yarn --pure-lockfile --production=true && \
  npx modclean -Pr -n default:safe,default:caution


FROM base AS statebuilder
ENV FLOGO_TAG_NAME ${CORE_VERSION}
ENV BUILD_DIR /tmp/build
WORKDIR ${BUILD_DIR}

COPY /tools/docker/build-state.sh ${BUILD_DIR}/build-state.sh
RUN chmod 755 build-state.sh && \
    ${BUILD_DIR}/build-state.sh


FROM base as release
ENV NODE_ENV production
ENV FLOGO_WEB_LOCALDIR /flogo-web/local
ENV FLOGO_WEB_PUBLICDIR /flogo-web/apps/client
#RUN build_packages="build-base linux-headers" \
#  && apk --update add ${build_packages} \
#  && cd /tmp \
#  && wget http://download.redis.io/releases/redis-3.2.4.tar.gz \
#  && tar xzf redis-3.2.4.tar.gz \
#  && cd /tmp/redis-3.2.4 \
#  && make \
#  && make install \
#  && cp redis.conf /etc/redis.conf \
#  && sed -i -e 's/bind 127.0.0.1/bind 0.0.0.0/' /etc/redis.conf \
#  && adduser -D redis \
#  && rm -rf /tmp/* \
#  && apk del ${build_packages} \
#  && rm -rf /var/cache/apk/*

COPY --from=builder /tmp/build/dist/ /flogo-web/
COPY --from=builder $GOPATH/ $GOPATH/
COPY --from=statebuilder $GOPATH/bin /flogo-web/flogo-services/

COPY ./tools/docker/flogo-eula /flogo-web/flogo-eula
COPY ./tools/docker/docker-start.sh /flogo-web/docker-start.sh

WORKDIR /flogo-web/
RUN cd local/engines/flogo-web && flogo build
ENTRYPOINT ["/flogo-web/docker-start.sh"]
