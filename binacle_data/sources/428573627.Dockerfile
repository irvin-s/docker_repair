FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y git postgresql-client python-pip python-dev python-psycopg2 libffi-dev libssl-dev libsqlite3-dev libxml2-dev libxslt-dev
RUN pip install uwsgi

ADD scripts /opt/dockerstack/scripts
ADD source/barbican /opt/dockerstack/source/barbican

RUN cp -r /opt/dockerstack/source/barbican/etc/barbican /etc/barbican

RUN pip install /opt/dockerstack/source/barbican

EXPOSE 9311

CMD ["/opt/dockerstack/scripts/run.sh"]
