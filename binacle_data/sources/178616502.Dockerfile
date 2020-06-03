FROM python:2.7

ENV PYTHONUNBUFFERED 1
RUN mkdir /source
WORKDIR /source
ADD requirements.txt /source/
RUN pip install -r requirements.txt
ADD . /source/

EXPOSE 8765

CMD python /source/ckanext/webhooks/eventloop.py
