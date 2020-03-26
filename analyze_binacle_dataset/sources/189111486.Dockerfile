FROM rounds/10m-python
MAINTAINER Ofir Petrushka

RUN \
  apt-get update && \
  apt-get install -y graphite-web gunicorn && \
  rm -fr /var/lib/apt/lists/*

COPY local_settintgs.py.example /etc/graphite/local_settings.py

RUN python /usr/lib/python2.7/dist-packages/graphite/manage.py syncdb --noinput

CMD gunicorn_django -b 0.0.0.0:80 /usr/lib/python2.7/dist-packages/graphite/settings.py
