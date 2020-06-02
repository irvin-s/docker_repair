FROM k0st/alpine-rt
MAINTAINER kost - https://github.com/kost

ENV RTIR_VERSION 3.2.0
# https://download.bestpractical.com/pub/rt/release/RT-IR-3.2.0.tar.gz

RUN  wget -O /tmp/RT-IR-$RTIR_VERSION.tar.gz https://download.bestpractical.com/pub/rt/release/RT-IR-$RTIR_VERSION.tar.gz && \
    tar -xvz -C /tmp -f /tmp/RT-IR-$RTIR_VERSION.tar.gz && \
    cd /tmp/RT-IR-$RTIR_VERSION && \
    cpan -f Parse::BooleanLogic && \
    perl Makefile.PL && \
    make install && \
    cd / && rm -rf RT-IR-$RTIR_VERSION RT-IR-$RTIR_VERSION.tar.gz && \
    echo "Success"

ADD scripts/ /scripts/

# Already part of alpine-rt
# EXPOSE 80
# ENTRYPOINT ["/scripts/run.sh"]

