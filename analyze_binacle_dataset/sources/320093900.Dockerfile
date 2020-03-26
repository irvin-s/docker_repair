FROM alpine:3.7

RUN apk update && apk add \
  bash \
  python3 \
	python3-dev \
	gcc \
	build-base \
	linux-headers \
	pcre-dev \
	nodejs \
	musl-dev \
	libxml2-dev \
	libxslt-dev \
	curl \
	supervisor && \
	python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache

# install uwsgi and create react app before any further changes, since these take a while
RUN pip3 install uwsgi

ENV APP_SERVICE_ROOT_DIR=/home/base/
ENV DJANGO_PROJECT_NAME=sampledjangoproject

#  npx create-react-app $APP_SERVICE_ROOT_DIR/frontend
# copy requirements.txt file in the directory containing this
# Dockerfile (on host machine) to $APP_SERVICE_ROOT_DIR/ in the container's file system
# and install its contents
COPY requirements.txt $APP_SERVICE_ROOT_DIR/
# and then run pip install BEFORE adding the rest of your code
# this will prevent Docker's caching mechanism from re-installing (all your)
# dependencies when you make small changes to you requirements.txt file
RUN pip3 install -r $APP_SERVICE_ROOT_DIR/requirements.txt

WORKDIR $APP_SERVICE_ROOT_DIR/
# copy all files in the directory containing this Dockerfile (on host machine)
# to $APP_SERVICE_ROOT_DIR/ in the container's file system

COPY . $APP_SERVICE_ROOT_DIR/

# the `startproject` command below is to check that the
# default django page show up on first run, confirming it works
# Normally, you would copy your django project folder
#into $APP_SERVICE_ROOT_DIR/ (in container)
#RUN django-admin.py startproject djangoprojectname .
# uncomment the copy command above^ if
# you don't already have a django project ready

RUN DJANGO_ENV=development python3 $APP_SERVICE_ROOT_DIR/backend/manage.py migrate
# start uwsgi
ENTRYPOINT uwsgi --master --ini $APP_SERVICE_ROOT_DIR/uwsgi.ini
