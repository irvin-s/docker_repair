FROM python:3.4

RUN mkdir /scrapyd
WORKDIR /scrapyd

COPY requirements.txt /scrapyd

RUN pip install --no-cache-dir -r requirements.txt \
    -i https://pypi.douban.com/simple --trusted-host pypi.douban.com
