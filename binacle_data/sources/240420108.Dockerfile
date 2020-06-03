FROM python:2.7
RUN pip install ansible coverage nose mock requests
WORKDIR /work
