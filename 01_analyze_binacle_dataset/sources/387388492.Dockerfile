FROM python:3.6.2

ENV PYTHONUNBUFFERED 1

# Requirements have to be pulled and installed here, otherwise caching won't work
COPY ./requirements /requirements

RUN pip install --upgrade pip
RUN pip install -r /requirements/production.txt \
    && groupadd -r django \
    && useradd -r -g django django


COPY . /app
RUN chown -R django /app

COPY ./compose/django/gunicorn.sh /gunicorn.sh
COPY ./compose/django/entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r//' /entrypoint.sh \
    && sed -i 's/\r//' /gunicorn.sh \
    && chmod +x /entrypoint.sh \
    && chown django /entrypoint.sh \
    && chmod +x /gunicorn.sh \
    && chown django /gunicorn.sh

RUN mkdir /app/staticfiles
RUN chown -R django /app/staticfiles

COPY ./compose/django/newrelic-template.ini /newrelic-template.ini

RUN apt-get -qq update
RUN apt-get -yqq install gettext-base

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
