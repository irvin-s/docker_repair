FROM aist-python

USER root

COPY requirements.txt /app/

WORKDIR /app

RUN pip install -r requirements.txt

COPY . /app

COPY supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]