FROM daocloud.io/python:3-onbuild

MAINTAINER Robin<robin.chen@b-uxin.com>

ENV LANG C.UTF-8

RUN  mkdir -p /app

WORKDIR /app

COPY /app /app
COPY base.txt /app
COPY requirements.txt /app

#安装Python程序运行的依赖库
RUN cd /app && pip install -r base.txt
RUN cd /app && pip install -r requirements.txt


EXPOSE 80


ENTRYPOINT ["python", "/app/ok_trade.py"]