FROM python:2.7-slim

COPY *.py /
COPY dvs-http.wsgi dvs-http.py
COPY requirements.txt .
COPY config/dvs-server.yaml config/dvs-server.yaml
COPY config/http.yaml config/http.yaml
COPY config/logging.yaml config/logging.yaml

RUN mkdir logs

RUN pip install -r requirements.txt
RUN pip install gunicorn

CMD [ "gunicorn", "-b", ":9000", "dvs-http:application" ]

EXPOSE 9000
