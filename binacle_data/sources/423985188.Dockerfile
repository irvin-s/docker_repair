FROM python:3-alpine

WORKDIR /home/app

COPY requirements.txt .

RUN python -m pip --no-cache-dir install -r requirements.txt

COPY . .

USER 1000:1000
