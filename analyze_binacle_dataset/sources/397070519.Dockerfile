## Dockerfile for the wagtail demo, runs eveything in one container

## Web admin: admin / test

# Installation script for a full install.. could be usefull in the future: https://wagtail.io/ubuntu.sh

FROM dockerfile/ubuntu
MAINTAINER Øyvind Skaar

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y postgresql  libpq-dev     # Demo can run on sqlite3, but the installer still looks for pg_.. bins
RUN apt-get install -y python-dev python-pip
RUN apt-get install -y libxml2-dev libxslt1-dev
RUN apt-get install -y libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev


# Wagtail demo
RUN cd / && git clone https://github.com/torchbox/wagtaildemo.git

RUN cd /wagtaildemo && pip install -r requirements/dev.txt

ADD prepare_db.sh /wagtaildemo/
RUN bash /wagtaildemo/prepare_db.sh

CMD /etc/init.d/postgresql start && cd /wagtaildemo && echo "Wagtail started on port 8000" && ./manage.py runserver 0.0.0.0:8000
