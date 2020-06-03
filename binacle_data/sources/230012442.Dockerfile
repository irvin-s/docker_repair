FROM python:2.7-slim

MAINTAINER Andrea Usuelli <andreausu@gmail.com>

ENV VERSION=0.5.6 \
    AUTHORIZATION_FAIL_MAX_RETRIES=3
    #B2_ACCOUNT_ID        if set at runtime, (re)authorization is performed automatically by this docker image
    #B2_APPLICATION_KEY   if set at runtime, (re)authorization is performed automatically by this docker image

RUN pip install b2==${VERSION}

COPY files/entrypoint.sh /entrypoint.sh
COPY files/upload_file_replace.py /usr/bin/b2_upload_file_replace

ENTRYPOINT [ "/entrypoint.sh" ]
