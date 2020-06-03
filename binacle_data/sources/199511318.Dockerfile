FROM python:2.7

WORKDIR /aws-amicleaner

ADD . .

RUN pip install -r requirements.txt

CMD amicleaner/cli.py -h
