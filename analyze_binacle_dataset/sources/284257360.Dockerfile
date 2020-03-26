FROM python:3.7.3-alpine3.9

WORKDIR /src
RUN pip install tornado
COPY client.py /src/client.py
ENTRYPOINT ["python", "/src/client.py"]
