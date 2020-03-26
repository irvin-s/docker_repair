FROM python:2.7

ENV PYTHONUNBUFFERED 1
RUN mkdir /source
WORKDIR /source
ADD requirements.txt /source/
RUN pip install -r requirements.txt
ADD . /source/

RUN apt-get update && apt-get install -y gdal-bin

EXPOSE 5000

CMD python /source/geopusher/main.py
