FROM python:2

EXPOSE 80 8080

ADD sink.py /opt/sink.py
CMD python -u /opt/sink.py
