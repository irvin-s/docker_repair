FROM postgres:9.2

RUN apt-get update
RUN apt-get install --yes           \
    postgresql-9.2-python-multicorn \
    python                          \
    python-pip
RUN pip install elasticsearch

COPY . /pg-es-fdw
WORKDIR /pg-es-fdw
RUN python setup.py install
