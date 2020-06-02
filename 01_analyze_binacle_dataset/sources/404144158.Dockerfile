FROM python:2.7-slim

WORKDIR /usr/src/

COPY requirements.txt .

RUN pip install -r requirements.txt

ENTRYPOINT ["python"]

CMD ["./scripts/py_server.py"]
