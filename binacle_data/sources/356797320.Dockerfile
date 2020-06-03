FROM python:2.7.10

COPY start.sh /
COPY requirements.txt /

RUN pip install -r requirements.txt && \
    git clone https://github.com/stefanteixeira/todoapp-flask.git

ENTRYPOINT ./start.sh
