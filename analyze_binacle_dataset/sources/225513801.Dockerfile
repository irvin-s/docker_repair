FROM python:3.4

ENV REDIS_HOST redis
ENV ORIENTDB_HOST orientdb_test
ENV IS_TEST True

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN pip install --upgrade pip
RUN apt-get update
RUN apt-get install build-essential gfortran libatlas-base-dev python-pip python-dev -y

ADD requirements.txt /usr/src/app/
RUN pip install -r /usr/src/app/requirements.txt
ADD . /usr/src/app

ADD run-web.sh /usr/local/bin/
ADD run-celery.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run-web.sh
RUN chmod +x /usr/local/bin/run-celery.sh

CMD ["run-web.sh"]