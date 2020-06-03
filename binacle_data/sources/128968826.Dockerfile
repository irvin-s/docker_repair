FROM python:2.7-wheezy

ADD ./ /opt/qasino
COPY src/docker-entrypoint.sh /opt/qasino

WORKDIR /opt/qasino/bin
RUN pip install -r /opt/qasino/requirements.txt


ENTRYPOINT ["/opt/qasino/docker-entrypoint.sh"]