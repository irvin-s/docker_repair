FROM python:3.4

COPY . /app/tweeter/
WORKDIR /app/tweeter/

RUN pip install -r /app/tweeter/requirements.txt
