FROM python:3.6.5
LABEL maintainer="https://hub.docker.com/u/svtwebcoreinfra"
LABEL description="ORM is a rule parser that converts ORM rule files to configuration files for use by HTTP routing software."

ARG ORM_TAG

WORKDIR /app

COPY . /app
RUN cd /app \
    && python setup.py sdist \
    && pip install dist/*.tar.gz

ENTRYPOINT ["orm"]
CMD ["--help"]
