FROM rakudo-star
MAINTAINER yowcow@cpan.org

RUN set -x && \
    apt-get update && \
    apt-get -yq install gcc g++ libc6-dev make && \
    rm -rf /var/lib/apt/lists/*

RUN zef install \
    Digest::MurmurHash3 \
    Test \
    Test::META

WORKDIR /tmp/work

COPY . /tmp/work

CMD perl6 -v
