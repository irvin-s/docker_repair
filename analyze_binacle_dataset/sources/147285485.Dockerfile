FROM python:3-onbuild
MAINTAINER Namjun Kim <bunseokbot@gmail.com>

ENV PYTHONUNBUFFERED 1

RUN printf "deb http://archive.debian.org/debian/ jessie main"\
           "\ndeb-src http://archive.debian.org/debian/ jessie main" \
           "\ndeb http://security.debian.org jessie/updates main" \
           "\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y libmysqlclient-dev libfontconfig bzip2 curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 /tmp/

RUN tar -xvjf /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2 phantomjs-2.1.1-linux-x86_64/bin/phantomjs \
    && mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/ \
    && rm /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    && rm -rf phantomjs-2.1.1-linux-x86_64

CMD ["python", "run_sources.py"]
