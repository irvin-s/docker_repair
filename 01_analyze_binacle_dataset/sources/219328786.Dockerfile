FROM python:2

COPY . /usr/src/app
WORKDIR /usr/src/app

ENTRYPOINT [ "./redis-statsd.py" ]
CMD [ "--help" ]
