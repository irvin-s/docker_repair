FROM python:3.6

RUN pip install -U former

ENTRYPOINT ["former"]