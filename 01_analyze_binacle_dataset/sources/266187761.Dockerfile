FROM python:2

WORKDIR /usr/src/app

RUN pip install pycrypto

COPY cbc_server.py .
COPY rahasia.py .

CMD [ "python", "./cbc_server.py" ]

