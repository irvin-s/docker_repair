FROM python:3.5-stretch
MAINTAINER Ioannis Noukakis <inoukakis@gmail.com>

SHELL ["/bin/bash", "-c"]
RUN apt-get update
RUN apt-get install uwsgi-plugin-python3 build-essential libjpeg-dev zlib1g-dev virtualenv -y
WORKDIR /opt/app/
COPY . /opt/app/
RUN virtualenv --python=$(which python3) venv && \
    source venv/bin/activate && \
    pip install . && \
    useradd -ms /bin/bash uwsgi && \
    chown -R uwsgi /usr/local/bin/python3 && \
    chown -R uwsgi /opt

USER uwsgi
CMD ["./runserver.sh"]
