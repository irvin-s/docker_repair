FROM python:3

ADD . /tmp/

RUN cd /tmp && \
    pip install --upgrade pip && \
    python setup.py install && \
    rm -rf *

ONBUILD ADD entrypoint-config.yml .

ENTRYPOINT ["pyentrypoint"]
