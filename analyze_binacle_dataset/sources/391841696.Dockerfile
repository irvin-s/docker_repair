FROM python:2.7-jessie
MAINTAINER Ioannis Noukakis <inoukakis@gmail.com>

SHELL ["/bin/bash", "-c"]
RUN apt-get update
RUN apt-get install uwsgi-plugin-python build-essential python-dev libmysqlclient-dev -y
WORKDIR /opt/app/
COPY . /opt/app/
RUN virtualenv venv && \
    source venv/bin/activate && \
    pip install . && \
    useradd -ms /bin/bash uwsgi && \
    chown -R uwsgi /usr/lib/python2.7 && \
    chown -R uwsgi /opt
USER uwsgi
ENTRYPOINT ["uwsgi"]
CMD ["radio-dns-plugit.ini"]