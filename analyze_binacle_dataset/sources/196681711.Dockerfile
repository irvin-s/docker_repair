FROM python:3.5.1-onbuild

MAINTAINER Theotime Leveque <theotime.leveque@gmail.com>

#PhantomJS
WORKDIR /usr/local/share
RUN wget -q https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
RUN tar xjf phantomjs-1.9.7-linux-x86_64.tar.bz2
RUN ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
RUN ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
RUN ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

# Official Python docker image is based on Debian Jessie (missing firefox)
# RUN echo deb http://packages.linuxmint.com debian import >> /etc/apt/sources.list
RUN apt-get update -y
# RUN apt-get install -y --force-yes firefox
RUN apt-get install -y xvfb iceweasel

# mongopath of mongo container
ENV DATABASE_URI mongodb://mongo/cabu

# S3 conf
ENV S3_BUCKET test
ENV S3_ACCESS_KEY test
ENV S3_SECRET_KEY test

WORKDIR /usr/src/app

# ONLY IN PRIVATE
RUN pip install flask-pymongo
RUN pip install -r requirements-dev.txt

CMD ["python", "dev_server.py"]
