FROM cvdelannoy/poretally-requirements:latest

MAINTAINER Carlos de Lannoy <carlos.delannoy@wur.nl>
ENV PATH=/root/miniconda3/bin:$PATH
RUN pip install git+https://github.com/cvdelannoy/poreTally.git && poreTally -h
ENTRYPOINT ["poreTally"]