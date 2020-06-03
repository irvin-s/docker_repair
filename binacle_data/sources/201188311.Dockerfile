FROM python:3.5-alpine

ENV MYCLI_VERSION 1.5.2

RUN set -x \
  && buildDeps='build-base openssl' \
  && apk add --update $buildDeps \
  && wget -O /tmp/py-setproctitle.tar.gz https://github.com/dvarrazzo/py-setproctitle/archive/version-1.1.9.tar.gz \
  && tar -xzvf /tmp/py-setproctitle.tar.gz -C /tmp \
  && cd /tmp/py-setproctitle-version-1.1.9/ \
  && sed -i 's:#include <linux/prctl.h>://#include <linux/prctl.h>:' ./src/spt_status.c \
  && python setup.py install \
  && pip install mycli==${MYCLI_VERSION} \
  && apk del $buildDeps \
  && rm -rf /var/cache/apk/* /tmp/py-setproctitle*

ENTRYPOINT ["/usr/local/bin/mycli"]
CMD ["--help"]
