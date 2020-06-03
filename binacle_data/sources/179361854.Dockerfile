# 3proxy docker

FROM alpine:latest as builder

ARG VERSION=0.8.12

RUN apk add --update alpine-sdk wget bash && \
    cd / && \
    wget -q  https://github.com/z3APA3A/3proxy/archive/${VERSION}.tar.gz && \
    tar -xf ${VERSION}.tar.gz && \
    cd 3proxy-${VERSION} && \
    make -f Makefile.Linux

# STEP 2 build a small image
FROM alpine:latest

MAINTAINER Riftbit ErgoZ <ergozru@riftbit.com>

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=0.8.12

LABEL org.label-schema.build-date=$BUILD_DATE \
	org.label-schema.name="3proxy Socks5 Proxy Container" \
	org.label-schema.description="3proxy Socks5 Proxy Container" \
	org.label-schema.url="https://riftbit.com/" \
	org.label-schema.vcs-ref=$VCS_REF \
	org.label-schema.vcs-url="https://github.com/riftbit/docker-3proxy" \
	org.label-schema.vendor="Riftbit Studio" \
	org.label-schema.version=$VERSION \
	org.label-schema.schema-version="1.0" \
	maintainer="Riftbit ErgoZ"

RUN mkdir /etc/3proxy/

COPY --from=builder /3proxy-${VERSION}/src/3proxy /etc/3proxy/
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk update && \
    apk upgrade && \
    apk add bash && \
    mkdir -p /etc/3proxy/cfg/traf &&\
    chmod +x /docker-entrypoint.sh && \
    chmod -R +x /etc/3proxy/3proxy

ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME ["/etc/3proxy/cfg/"]

EXPOSE 3128:3128/tcp 1080:1080/tcp 8080/tcp

CMD ["start_proxy"]
