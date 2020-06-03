FROM python

VOLUME /root

WORKDIR /root

ADD ./application/requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

EXPOSE 80

CMD django-admin startproject myapp . || \
    gunicorn --bind 0.0.0.0:80 --reload myapp.wsgi:application
