#########################################
# Python3 flask server for REST API backend

FROM pdonorio/py3kbase
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    # nginx for uwsgi
    nginx \
    # CLEAN
    && apt-get clean autoclean && apt-get autoremove -y && \
    rm -rf /var/lib/cache /var/lib/log

# Install the micro framework and important plugins
RUN pip install --upgrade pip \
    # unittests
    nose nose2 cov-core \
	# coverage http://nose.readthedocs.org/en/latest/plugins/cover.html
	coverage \
	# Flask server for HTTP API
	Flask==0.12 \
    # latest restful because the stable release is pretty outdated
    git+https://github.com/flask-restful/flask-restful@master \
	# Flask main plugins
	flask-sqlalchemy flask-cors pyopenssl flask-oauthlib \
    # swagger validation
    bravado_core \
	##########################
	# SERVICEs APIs
	##########################
    redis \
    celery \
    elasticsearch elasticsearch-dsl \
    # wsgi for production
    uwsgi uwsgitop \
	##########################
	# The real Token
	pyjwt

RUN mkdir -p /code
WORKDIR /code
