FROM python:2

ADD . /app

WORKDIR /app

CMD ["pip", "install -r requirements.txt"]

CMD ["python", "server.py"]

EXPOSE 1688