FROM python:2.7

ARG uid=1000
ARG gid=1000

RUN getent group $gid || groupadd --gid $gid forseti
RUN getent passwd $uid || useradd -m -u $uid -g $gid forseti

RUN chown -R $uid:$gid /usr/local

COPY requirements/base.txt /code/
RUN pip install -r /code/base.txt

USER $uid
