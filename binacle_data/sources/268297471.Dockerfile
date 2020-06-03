FROM python:3

ADD . /usr/src
WORKDIR /usr/src

RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["python", "server.py"]