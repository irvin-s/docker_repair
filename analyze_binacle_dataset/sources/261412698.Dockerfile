FROM python:3.6-alpine

RUN pip install flask pymongo parse

ADD ./slo_config /web
ADD config.ini /config.ini

WORKDIR /web
EXPOSE 5000
ENV FLASK_APP /web/app.py

CMD flask run -h 0.0.0.0 -p 5000
