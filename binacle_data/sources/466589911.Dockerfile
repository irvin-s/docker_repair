FROM python:3.6
RUN adduser --disabled-login jasmine
WORKDIR /home/jasmine
COPY . .
# add for pymysql
COPY ./sources.list /etc/apt/
RUN apt-get update &&apt-get install libssl-dev
RUN pip install -r requirements.txt -i https://pypi.doubanio.com/simple/
RUN chmod -R +x .
