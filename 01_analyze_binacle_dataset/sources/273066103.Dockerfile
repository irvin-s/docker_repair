FROM ubuntu:16.04

RUN apt update && apt upgrade -y

WORKDIR /root/

ADD requirements.txt /root/

RUN apt install python2.7 python-virtualenv -y
RUN virtualenv venv
RUN /root/venv/bin/pip install -r requirements.txt

ADD configuration/ /root/configuration/
ADD wait-service.sh /root/

CMD ./wait-service.sh persistence 5432 && \
    ./wait-service.sh processes 21 && \
    /root/venv/bin/python /root/configuration/models.py && \
    /root/venv/bin/python /root/configuration/parametric.py && \
    cd /root/configuration; /root/venv/bin/gunicorn -b 0.0.0.0:80 wsgi
