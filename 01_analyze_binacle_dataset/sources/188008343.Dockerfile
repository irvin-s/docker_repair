FROM tiangolo/uwsgi-nginx-flask:python2.7

WORKDIR /app

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-client mysql-server default-libmysqlclient-dev build-essential

ADD requirements.txt /app/

RUN pip install --trusted-host pypi.python.org -r requirements.txt

ADD . /app
