FROM python:3.5 AS builder

ENV PYTHONUNBUFFERED 1

RUN mkdir -p /opt/memcached_operator
WORKDIR /opt/memcached_operator

COPY Pipfile \
     Pipfile.lock \
     memcached_operator.py \
     /opt/memcached_operator/

COPY memcached_operator/ \
    /opt/memcached_operator/memcached_operator/

RUN pip install pipenv \
    && pipenv install \
    && ln -s `pipenv --py` /root/.local/share/virtualenvs/python

FROM python:3.5-slim

COPY --from=builder /root/.local/share/virtualenvs /root/.local/share/virtualenvs
COPY --from=builder /opt/memcached_operator /opt/memcached_operator

WORKDIR /opt/memcached_operator
ENV PATH /root/.local/share/virtualenvs:$PATH

ENTRYPOINT ["python", "memcached_operator.py"]
