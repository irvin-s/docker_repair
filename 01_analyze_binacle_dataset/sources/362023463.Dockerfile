FROM alpine:latest

RUN apk update && apk add python py-pip
RUN mkdir -p /srv/webapp
ADD webapp.py /srv/webapp/webapp.py
ADD requirements.txt /srv/webapp/requirements.txt
RUN pip install -r /srv/webapp/requirements.txt
CMD python /srv/webapp/webapp.py

LABEL \
  com.opentable.sous.repo_url=github.com/example/webapp \
  com.opentable.sous.repo_offset= \
  com.opentable.sous.version=0.0.17-maybeuseful \
  com.opentable.sous.revision=91495f1b1630084e301241100ecf2e775f6b672c
