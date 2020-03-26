FROM phusion/baseimage:0.9.22

RUN apt-get update -y && apt-get install -y tmux nginx python3 python3-pip python3-dev postgresql-9.5 postgresql-client-9.5 \
                       postgresql-contrib-9.5 libssl-dev build-essential gfortran libatlas-base-dev liblapacke-dev redis-server
RUN pip3 install flask uwsgi uwsgitop psycopg2 ujson Pyro4 flask_sslify peewee flask_mail applicationinsights \
                 voluptuous requests tweepy newspaper3k PyJWT Flask-Environ python-jose flask-cors iso8601 tqdm \
                 flask-socketio gevent gevent-websocket sklearn numpy Cython scipy gensim keras tensorflow

# requires above libraries to be already installed :/
RUN pip3 install libact
RUN pip3 install elasticsearch xmltodict boto3 celery redis
RUN pip3 install h5py

ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD . /src
RUN mkdir /src/data

RUN mkdir /etc/service/uwsgi
COPY api/docker_uwsgi.sh /etc/service/uwsgi/run
RUN chmod +x /etc/service/uwsgi/run

RUN mkdir /etc/service/nginx
COPY api/docker_nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

RUN mkdir /var/log/uwsgi

COPY api/docker_nginx.conf        /etc/nginx/nginx.conf
ADD  api/docker_nginx_site.conf   /etc/nginx/sites-available/default

EXPOSE 80

CMD ["/sbin/my_init"]