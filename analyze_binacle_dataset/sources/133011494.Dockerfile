FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y \
        python \
        python-dev \
        python-setuptools \
        python-pip \
        python-numpy \
        python-scipy \
        python-pymongo \
        python-networkx \
        python-yaml \
        python-psycopg2 \
        python-matplotlib \
        python-shapely \
        python-pandas \
        python-wxgtk2.8 \
        python-opencv \
        supervisor \
        mafft

WORKDIR /app/

COPY requirements.txt /app/

RUN pip install -r requirements.txt

ADD supervisord.conf /etc/supervisor/conf.d/cron.conf

ADD . /app/

RUN pip install .

RUN ln -s /app/config/crontab /etc/cron.d/aggregation

EXPOSE 5000

ENTRYPOINT ["/app/start.sh"]
