FROM python:2.7

RUN mkdir /netapiclient
WORKDIR /netapiclient

ADD . /netapiclient/

CMD cd /netapiclient


RUN pip install -r requirements.txt
RUN pip install -r requirements_test.txt
