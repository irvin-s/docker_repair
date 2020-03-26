FROM ubuntu

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get install python-dev -y
RUN apt-get install python-pip -y
RUN apt-get build-dep python-psycopg2 -y

RUN easy_install -U distribute
RUN pip install sentry
RUN pip install gevent
RUN pip install eventlet
RUN pip install django-bcrypt
RUN pip install psycopg2 

ADD conf/sentry/sentry.conf.py /opt/sentry.conf.py

EXPOSE 9000/tcp 9001/udp

ENTRYPOINT ["sentry", "--config=/opt/sentry.conf.py"]
CMD ["help"]
