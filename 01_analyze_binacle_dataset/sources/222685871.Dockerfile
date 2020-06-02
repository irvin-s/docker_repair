FROM python:3.6

MAINTAINER Mesut Tasci

ENV PYTHONUNBUFFERED 1

RUN apt-get update
RUN apt-get install --no-install-recommends -y supervisor


RUN pip install --upgrade pip
RUN pip install uwsgi 


# Run uwsgi unpriviledged
RUN groupadd uwsgi && useradd -g uwsgi uwsgi

COPY . /srv/
RUN ln -s /srv/supervisor-app.conf /etc/supervisor/conf.d/

RUN pip install -r /srv/app/requirements.txt

RUN chown -R uwsgi:uwsgi /srv


EXPOSE 9000

# uWSGI stats server port
# EXPOSE 9001

CMD ["supervisord", "-n"]
