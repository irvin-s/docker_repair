FROM ubuntu:16.04

RUN apt update && apt upgrade -y

WORKDIR /root/

ADD requirements.txt /root/

RUN apt install python2.7 python-virtualenv -y
RUN virtualenv venv
RUN /root/venv/bin/pip install -r requirements.txt

RUN apt install git python-dev gcc -y
RUN /root/venv/bin/pip install -e git+https://github.com/geopython/pywps.git@5efa0513fe096b8eb3b3a0399b22403209623ff3#egg=pywps-dev
RUN /root/venv/bin/pip install flufl.enum pathlib

ADD wps/ /root/wps/
ADD wait-service.sh /root/

RUN mkdir /root/outputs
RUN mkdir /root/workdir
RUN mkdir /root/logs

CMD ./wait-service.sh configuration 80 && \
    cd /root/wps; /root/venv/bin/gunicorn -b 0.0.0.0:80 wsgi
