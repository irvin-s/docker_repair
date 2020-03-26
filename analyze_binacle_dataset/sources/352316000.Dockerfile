FROM ubuntu:14.10

RUN apt-get update -y
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10
RUN apt-get update -y
RUN apt-get install python mongodb-org -y
WORKDIR /home
ADD run.py /home/run.py
EXPOSE 30001

RUN mkdir -p /data/db


CMD /home/run.py

