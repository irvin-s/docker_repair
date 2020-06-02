FROM python:2.7-slim

RUN pip install gunicorn json-logging-py

COPY logging.conf /logging.conf
COPY gunicorn.conf /gunicorn.conf

COPY myapp.py /

EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/gunicorn", "--config", "/gunicorn.conf", "--log-config", "/logging.conf", "-b", ":8000", "myapp:app"]
