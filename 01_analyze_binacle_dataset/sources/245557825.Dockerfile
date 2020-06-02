FROM alpine:latest

WORKDIR /opt/google

RUN apk --no-cache add \
    libpng-dev \
    g++ \
    git \
    make

ARG VERSION="v1.0.1"

RUN git clone https://github.com/google/guetzli.git \
    --branch "${VERSION}" \
    --depth 1

RUN cd guetzli && make

WORKDIR /tmp

ENTRYPOINT ["/opt/google/guetzli/bin/Release/guetzli"]