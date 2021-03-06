FROM python:3.5

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

ADD requirements-base.txt /tmp/lmc/
RUN cd /tmp/lmc \
    && pip3 install --upgrade -r requirements-base.txt \
    && rm -r /tmp/lmc
