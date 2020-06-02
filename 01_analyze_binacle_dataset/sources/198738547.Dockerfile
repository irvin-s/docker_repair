FROM malice/alpine

LABEL maintainer "https://github.com/blacktop"

LABEL malice.plugin.repository = "https://github.com/malice-plugins/pescan.git"
LABEL malice.plugin.category="exe"
LABEL malice.plugin.mime="application/x-dosexec"
LABEL malice.plugin.docker.engine="*"

COPY . /usr/sbin
RUN apk --update add --no-cache python py-setuptools py-magic
RUN apk --update add --no-cache -t .build-deps \
  openssl-dev \
  build-base \
  python-dev \
  libffi-dev \
  musl-dev \
  libc-dev \
  py-pip \
  gcc \
  git \
  && set -ex \
  && echo "===> Install malice/pescan plugin..." \
  && cd /usr/sbin \
  && export PIP_NO_CACHE_DIR=off \
  && export PIP_DISABLE_PIP_VERSION_CHECK=on \
  && pip install --upgrade pip wheel \
  && echo "\t[*] install requirements..." \
  && pip install -U -r requirements.txt \
  && pip list \
  && echo "\t[*] install pescan.py..." \
  && chmod +x pescan.py \
  && ln -s /usr/sbin/pescan.py /usr/sbin/pescan \
  && echo "\t[*] clean up..." \
  && rm requirements.txt Dockerfile \
  && apk del --purge .build-deps

WORKDIR /malware

ENTRYPOINT ["su-exec","malice","/sbin/tini","--","pescan"]
CMD ["--help"]
