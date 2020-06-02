FROM python:3.5

ENV TOXENV py35

ADD . /app
WORKDIR /app

RUN pip install -r requirements.dev.txt

CMD tox -e $TOXENV
