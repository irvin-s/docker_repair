FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&& apt-get install -y python3-pip python3-dev \
&& cd /usr/local/bin \
&& ln -s /usr/bin/python3 python \
&& pip3 install --upgrade pip

WORKDIR /app
COPY requirements.txt /

RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository -y ppa:alex-p/tesseract-ocr
RUN apt-get update && apt-get --fix-missing -y install poppler-utils libsm6 tesseract-ocr libxext6 ca-certificates ghostscript pdftk imagemagick && apt-get clean

RUN pip install -r /requirements.txt

COPY . /app

EXPOSE 5051

CMD gunicorn --workers=2 --bind=0.0.0.0:5051 --reload -t 300 --log-level=info app:app