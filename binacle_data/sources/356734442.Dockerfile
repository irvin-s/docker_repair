#########################################
# The python3 base for flask boilerplate (front-end)

FROM pdonorio/py3api
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

RUN apt-get update && apt-get install -y -q \
    language-pack-en \
    libffi-dev \
    && apt-get clean autoclean && apt-get autoremove -y && \
    rm -rf /var/lib/cache /var/lib/log
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Connection via sqlalchemy
RUN pip3 install --upgrade \
    setuptools cffi tox 'cython>=0.23.4' \
    sqlalchemy psycopg2 Werkzeug Flask-SQLAlchemy \
    flask_table Flask-WTF WTForms-Alchemy \
    psutil==5.4.3 \
    meinheld tornado \
    git+git://github.com/gevent/gevent.git#egg=gevent \
    git+https://github.com/pdonorio/commentjson@master \
    flask_login

VOLUME /data
WORKDIR /data
