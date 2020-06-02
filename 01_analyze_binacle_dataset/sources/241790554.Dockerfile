FROM python:3.4

RUN mkdir /scrapy
WORKDIR /scrapy

COPY requirements.txt /scrapy

RUN pip install --no-cache-dir -r requirements.txt \
    -i https://pypi.douban.com/simple --trusted-host pypi.douban.com
