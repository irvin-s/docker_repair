FROM python:3-slim

MAINTAINER nicolas@movio.co

WORKDIR /usr/src/app

COPY LICENSE /usr/src/app/
COPY requirements.txt /usr/src/app/
RUN pip install -r requirements.txt

COPY samza_prometheus_exporter/*.py /usr/src/app/samza_prometheus_exporter/
COPY setup.py /usr/src/app/
RUN pip install . --no-deps

ENV PORT=8080
ENV BROKERS=dockerhost
ENV TOPIC=samza-metrics
ENV INCLUDE_JOBS_REGEX=.*

CMD python -u /usr/local/bin/samza-prometheus-exporter --brokers $BROKERS --port $PORT --topic $TOPIC --include-jobs-regex "$INCLUDE_JOBS_REGEX"
