FROM python:3.5.2-alpine

RUN apk update && apk add --no-cache \
  gcc \
  musl-dev \
  ca-certificates

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .

CMD ["gunicorn", "main:app", "-b", "0.0.0.0:8000", "--worker-class", "gevent", "--access-logfile", "-", "--log-level", "info", "--log-syslog"]
