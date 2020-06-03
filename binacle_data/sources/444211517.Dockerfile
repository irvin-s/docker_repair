FROM gliderlabs/alpine:3.4

MAINTAINER blacktop, https://github.com/blacktop

# Add scripts
COPY nsrl /nsrl
RUN apk-install tini
RUN apk-install -t .build-deps gcc libc-dev python-dev py-pip p7zip \
  && set -x \
  && apk --update add python $buildDeps \
  && rm -f /var/cache/apk/* \
  && pip install pybloom \
  && /nsrl/shrink_nsrl.sh \
  && apk del --purge .build-deps \
  && rm -rf /tmp/* /root/.cache /var/cache/apk/* /nsrl/shrink_nsrl.sh

WORKDIR /nsrl

ENTRYPOINT ["/sbin/tini","--","/nsrl/search.py"]

CMD ["-h"]
