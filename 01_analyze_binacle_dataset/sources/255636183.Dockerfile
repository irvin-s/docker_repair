FROM python:3.5

ENV PYTHONUNBUFFERED 1

# Requirements have to be pulled and installed here, otherwise caching won't work
COPY ./requirements /requirements

RUN pip install -r /requirements/production.txt \
    && groupadd -r django \
    && useradd -r -g django django

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y ruby rubygems-integration inotify-tools
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

WORKDIR /app

COPY . /app

RUN npm install

RUN chown -R django /app

COPY ./compose/django/gunicorn.sh /gunicorn.sh
COPY ./compose/django/entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r//' /entrypoint.sh \
    && sed -i 's/\r//' /gunicorn.sh \
    && chmod +x /entrypoint.sh \
    && chown django /entrypoint.sh \
    && chmod +x /gunicorn.sh \
    && chown django /gunicorn.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
