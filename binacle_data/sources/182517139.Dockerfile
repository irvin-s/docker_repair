FROM rakudo-star
MAINTAINER yowcow@cpan.org

RUN set -eux; \
    apt-get update && \
    apt-get install -y make

RUN mkdir /work

WORKDIR /work

CMD perl6 -v
