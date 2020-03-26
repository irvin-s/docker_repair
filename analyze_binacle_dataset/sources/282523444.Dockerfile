#@IgnoreInspection BashAddShebang
FROM python:2.7-onbuild


ADD . /example-project
WORKDIR /example-project
CMD python run_spider.py -master 1