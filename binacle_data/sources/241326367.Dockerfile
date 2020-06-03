# envsubst
# docker run --rm -it -v $(pwd):/tmp -e ARG=arg supinf/envsubst /tmp/target.yml

FROM alpine:3.9

ADD entrypoint.sh /

RUN chmod +x /entrypoint.sh \
    && apk --no-cache add gettext bash \
    && rm -rf /usr/share/terminfo

WORKDIR /work

ENTRYPOINT ["/entrypoint.sh"]
