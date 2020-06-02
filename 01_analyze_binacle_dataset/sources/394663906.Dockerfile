FROM google/python

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN apt-get update && apt-get install -y \
	python-setuptools python-pip python-dev \
	libxslt1-dev libxml2-dev libz-dev libffi-dev libssl-dev

ADD run.sh /run.sh
ADD sentry.conf.py /sentry.conf.py

VOLUME ["/env", "/data"]

EXPOSE 80

CMD ["/run.sh"]
