FROM python:3.7
MAINTAINER Ioannis Noukakis <inoukakis@gmail.com>

COPY . /opt/app/
WORKDIR /opt/app/

RUN pip install .

CMD python app.py