FROM ubuntu:16.04
MAINTAINER Colin Powell "colin.powell@gmail.com"
RUN apt-get -qq update
RUN apt install -y libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev \
                liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk \
                libxslt-dev libxml2-dev libmemcached-dev python3-pip
RUN ["pip3", "install", "outline"]
EXPOSE 8000
ENTRYPOINT ["gunicorn", "outline.wsgi"]
