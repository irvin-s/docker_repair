FROM python:2.7

ENV VERSION 1.1.2
ENV URL https://github.com/sqlmapproject/sqlmap/archive/$VERSION.tar.gz
ENV HOST 127.0.0.1
ENV PORT 8775

ADD $URL /opt/sqlmap.tar.gz

RUN tar xzvf /opt/sqlmap.tar.gz -C /opt

WORKDIR /opt/sqlmap-$VERSION

CMD python sqlmapapi.py -s --host=$HOST --port=$PORT