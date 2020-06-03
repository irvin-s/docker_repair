FROM python:2.7.15-slim-stretch

WORKDIR /duct

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install build-essential python-cryptography python-twisted python-protobuf python-yaml python-openssl

RUN mkdir -p /duct/conf.d

ADD duct duct
ADD twisted twisted
ADD requirements.txt .
ADD setup.py .
ADD docker/duct.yml .

RUN pip install -e .

RUN apt-get -y purge build-essential
RUN apt-get -y autoremove
RUN apt-get clean

USER 65534

CMD twistd --pidfile=/tmp/duct.pid -n duct -c /duct/duct.yml
