FROM python:3.6
RUN mkdir -p /code/log
RUN mkdir -p /code/data
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -i http://pypi.douban.com/simple  -r requirements.txt --trusted-host pypi.douban.com
RUN pip install -i http://pypi.douban.com/simple misaka cryptography --trusted-host pypi.douban.com
EXPOSE 1064