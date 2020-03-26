FROM python:3.7

ENV PYTHONUNBUFFERED 1
ENV VIRTUAL_ENV /env
ENV PYTHON_PIP_VERSION 9.0.1
ENV DJANGO_SETTINGS_MODULE ealgis.settings

RUN pyvenv "$VIRTUAL_ENV" && \
    "$VIRTUAL_ENV"/bin/pip install -U pip==$PYTHON_PIP_VERSION

ENV PATH "$VIRTUAL_ENV"/bin:$PATH

RUN mkdir /app

WORKDIR /app

# Upgrade SetupTools from 28.8 to latest due to a bug installing python-memcached on Python 3.6
# c.f. https://github.com/pypa/setuptools/issues/866
RUN pip3 install -U setuptools

ADD requirements.txt /app/
RUN pip install -r requirements.txt
ADD . /app/
RUN pip install -e .

ENTRYPOINT ["/app/docker-entrypoint.sh"]
