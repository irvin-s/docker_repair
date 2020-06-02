FROM python:2.7

ADD requirements.txt /
RUN pip install -r /requirements.txt && \
    apt-get update && \
    apt-get -y install chromium-driver

VOLUME /templates

ADD *.py /
ADD web-flags.txt /

CMD python /app.py