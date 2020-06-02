FROM python:2.7
RUN	apt-get -qqy update && \
	apt-get -qqy install libmemcached-dev
WORKDIR	/app
COPY	requirements.txt /app/requirements.txt
RUN	pip install -r requirements.txt
COPY	. /app

CMD	["python", "./runserver.py"]
EXPOSE	5000/tcp
