FROM python:3-slim-stretch

ARG VERSION
ENV CURATOR_VERSION=$VERSION

RUN pip install -U --quiet elasticsearch-curator=="${CURATOR_VERSION}"

ENTRYPOINT [ "/usr/local/bin/curator" ]
