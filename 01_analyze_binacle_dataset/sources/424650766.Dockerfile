FROM ubuntu:18.04
ARG DEV_INSTALL
MAINTAINER Amara "http://amara.org"
ENV DEBIAN_FRONTEND noninteractive
RUN (echo "deb http://archive.ubuntu.com/ubuntu bionic main universe multiverse" > /etc/apt/sources.list)
RUN (echo "deb-src http://archive.ubuntu.com/ubuntu bionic main universe multiverse" >> /etc/apt/sources.list)
RUN (echo "deb http://archive.ubuntu.com/ubuntu bionic-updates main universe multiverse" >> /etc/apt/sources.list)
RUN (echo "deb-src http://archive.ubuntu.com/ubuntu bionic-updates main universe multiverse" >> /etc/apt/sources.list)
RUN apt-get update
RUN apt-get -y install wget python-dev python-setuptools python-pip make gcc libmysqlclient-dev supervisor libxml2-dev libxslt-dev zlib1g-dev swig libffi-dev libssl-dev libyaml-dev git-core python-m2crypto icedtea-netx libjpeg-dev libfreetype6-dev gettext build-essential gcc dialog mysql-client node-uglify ruby-sass ffmpeg libz-dev tzdata
ENV APP_DIR /opt/apps/amara
ENV CLOSURE_PATH /opt/google-closure
RUN git clone https://github.com/google/closure-library $CLOSURE_PATH
RUN (cd $CLOSURE_PATH && git checkout adbcc8ef6530ea16bac9f877901fe6b32995c5ff)
# install urllib3[secure] before other packages.  This prevents SSL warnings
RUN pip install --upgrade urllib3[secure]
RUN mkdir -p /opt/extras/pictures
RUN mkdir -p /opt/extras/videos
RUN mkdir -p /var/run/amara
RUN useradd --home /var/run/amara --shell /bin/bash amara
RUN mkdir /var/run/amara/test-output/
RUN chown -R amara:amara /var/run/amara
RUN mkdir -p /var/run/pytest && chown amara:amara /var/run/pytest
COPY deploy /tmp/deploy
WORKDIR /var/run/amara
EXPOSE 8000
ENV MANAGE_SCRIPT /opt/apps/amara/manage.py
ENV DJANGO_SETTINGS_MODULE unisubs_settings
ENV REVISION staging
ENTRYPOINT ["/usr/local/bin/entry"]
CMD ["app"]
COPY .docker/known_hosts /root/.ssh/known_hosts
COPY .docker/bin/* /usr/local/bin/
COPY . /opt/apps/amara
RUN ln -sf $CLOSURE_PATH $APP_DIR/media/js/closure-library
RUN (cd /tmp/deploy && ./install-requirements.sh)
USER amara
