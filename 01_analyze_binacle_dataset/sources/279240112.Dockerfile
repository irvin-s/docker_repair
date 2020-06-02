FROM python:2.7-alpine

ADD requirements-Docker.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
ADD . /code
WORKDIR /code

CMD ["python", "app.py", "--use-redis"]
