FROM python:2.7

RUN mkdir /openstates
WORKDIR /openstates
COPY . /openstates/

RUN pip install -r requirements.txt
