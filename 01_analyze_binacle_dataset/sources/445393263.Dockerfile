FROM aist-python

USER root

COPY requirements.txt /app/

WORKDIR /app

RUN pip install -r requirements.txt

COPY . /app

COPY supervisord.conf /etc/supervisord.conf

ENV PATH /bin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/sbin

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]