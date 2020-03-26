FROM python:3.4-slim

RUN mkdir /django

WORKDIR /django

COPY requirements.txt /django

RUN pip install --no-cache-dir -r requirements.txt \
    -i https://pypi.douban.com/simple --trusted-host pypi.douban.com

