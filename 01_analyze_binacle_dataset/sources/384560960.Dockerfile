FROM python:2.7-slim

COPY *.py /
COPY dvs-http.wsgi .
COPY requirements.txt .
COPY config/dvs-server.yaml config/dvs-server.yaml
COPY config/http.yaml config/http.yaml
COPY config/logging.yaml config/logging.yaml

RUN mkdir logs

RUN pip install -r requirements.txt

CMD [ "python", "dvs-daemon.py"]

EXPOSE 8120 8140
