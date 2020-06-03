FROM tiangolo/uwsgi-nginx-flask:python3.7

WORKDIR /app

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential python3-dev python3-pip python3-setuptools python3-wheel python3-cffi libcairo2 libpango-1.0-0 libpangocairo-1.0-0 libgdk-pixbuf2.0-0 libffi-dev shared-mime-info

ADD requirements.txt /app/

RUN pip install --trusted-host pypi.python.org -r requirements.txt

ADD . /app
