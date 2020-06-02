FROM python:3

RUN pip install --no-cache-dir --upgrade twisted txaioetcd

VOLUME /examples

CMD ["/bin/bash", "/examples/run.sh"]
