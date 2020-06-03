FROM bash:4.3
LABEL maintainer="housni.yakoob@gmail.com"

RUN set -ex; \
    apk add --no-cache \
        gawk

CMD ["bash"]