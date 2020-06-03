FROM python:3-slim

RUN apt-get update -q && \
apt-get install -y --no-install-recommends \
  build-essential \
  libmysqlclient-dev && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY prometheus_mysql_exporter/*.py /usr/src/app/prometheus_mysql_exporter/
COPY setup.py /usr/src/app/
COPY LICENSE /usr/src/app/
COPY README.md /usr/src/app/
COPY MANIFEST.in /usr/src/app/

RUN pip install -e .

EXPOSE 9207

ENTRYPOINT ["python", "-u", "/usr/local/bin/prometheus-mysql-exporter"]
