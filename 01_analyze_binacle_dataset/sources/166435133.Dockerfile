# FROM revolutionsystems/python:3.6.3-wee-optimized-lto
FROM python:3.6

#Install Cairo (necessary to make url links work in pdf files.)
WORKDIR /tmp
#ADD ./aristotle-cloud/dev/sh/cairo-installer.sh /tmp/
ADD ./docker/sh/cairo-installer.sh /tmp/
RUN sh cairo-installer.sh
RUN rm -r /tmp

# Use the same pip and pipenv as heroku
RUN pip install -U setuptools pip==9.0.2 pipenv==11.8.2 && pip --version && \
    pip install whoosh gunicorn tox whitenoise~=3.3.0 psycopg2
ADD . /usr/src/app
WORKDIR /usr/src/app/docker

ENV DJANGO_SETTINGS_MODULE=settings \
    aristotlemdr__BASE_DIR=/data/ \
    aristotlemdr_STATIC_DIR=/data/staticfiles

RUN sh ./sh/install.sh

RUN mkdir -p /data && mkdir -p /data/staticfiles
EXPOSE 8000

CMD sh ./docker/entrypoint/web.sh
