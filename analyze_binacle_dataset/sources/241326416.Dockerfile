# ShellCheck http://www.shellcheck.net
# docker run --rm -v $(pwd):/work supinf/shellcheck:0.x
# docker run --rm -v $(pwd):/work -e IGNORE_PATH=/vendor/ supinf/shellcheck:0.x

FROM alpine:3.9

ENV SHELLCHECK_VERSION=v0.6.0

RUN apk --no-cache add "bash=4.4.19-r1"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apk --no-cache --virtual=build-deps add curl \
    && tar=shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz \
    && curl -sSL https://shellcheck.storage.googleapis.com/${tar} -o shellcheck.tar.gz \
    && echo "d88733e95aea8e970c373a3f677a3eb272f14c12d3e9c93f81463b5fe406b43acdd3046d10c092f40c070a96a5fac1cf7e18b35ed790d76ecced6af32e2c8a85  shellcheck.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/src/shellcheck \
    && tar xvf shellcheck.tar.gz \
    && mv shellcheck-*/shellcheck /usr/bin/ \
    && rm -rf shellcheck* \
    && apk del --purge -r build-deps

WORKDIR /work

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
