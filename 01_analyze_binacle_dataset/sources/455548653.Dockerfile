FROM ubuntu:xenial

LABEL Description="SPIRE Demo: Blog"
LABEL vendor="scytale.io"
LABEL version="0.1.0"

RUN apt-get update -y
RUN apt-get -y install \
    python-pip \
	python-mysqldb \
	git

RUN \
  cd ${HOME} && \
  git clone https://github.com/sh4nks/flaskbb.git && \
  cd flaskbb && \
  pip install -r requirements.txt

COPY flaskbb.cfg .
EXPOSE 8080

CMD flaskbb --config flaskbb.cfg run --host 0.0.0.0 --port 8080

