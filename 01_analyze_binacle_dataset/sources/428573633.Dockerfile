FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y keystone python-psycopg2 postgresql-client

ADD scripts/ /opt/dockerstack/scripts

EXPOSE 5000 35357

CMD ["/opt/dockerstack/scripts/run.sh"]
