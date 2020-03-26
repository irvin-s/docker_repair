FROM python:2

ADD test.py /opt/test.py
CMD python -u /opt/test.py
