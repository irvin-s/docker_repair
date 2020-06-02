FROM python:2.7
ENV PYTHONUNBUFFERED 1

RUN groupadd -r django && useradd -r -g django django

# Requirements have to be pulled and installed here, otherwise caching won't work
ADD ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ADD . /app

ADD ./compose/django/uwsgi.sh /uwsgi.sh
RUN chmod +x /uwsgi.sh

RUN chown -R django /app

WORKDIR /app