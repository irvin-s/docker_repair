FROM alpine:latest

RUN apk update && apk add python
ADD succeed.py /usr/local/bin/succeed.py
CMD python /usr/local/bin/succeed.py

LABEL \
  com.opentable.sous.repo_url=github.com/user/succeedthenfail \
  com.opentable.sous.repo_offset= \
  com.opentable.sous.version=1.0.0-succeed \
  com.opentable.sous.revision=91495f1b1630084e301241100ecf2e775f6b672c
