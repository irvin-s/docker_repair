FROM python:3.7-slim

WORKDIR /usr/src/app

RUN pip install --no-cache-dir pipenv

COPY * ./

RUN pipenv install --system

ENTRYPOINT [ "python", "./zabbix-etl.py" ]

CMD [ "--help" ]
