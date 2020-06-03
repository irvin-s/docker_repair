# Image: jstubbs/abaco_transfer
# This image is an example abaco actor that transfers a file uploaded to an agave system to a remote storage system.
from alpine:3.2

RUN apk add --update musl python3 && rm /var/cache/apk/*
RUN apk add --update bash && rm -f /var/cache/apk/*
RUN apk add --update git && rm -f /var/cache/apk/*
RUN apk add --update python3-dev -f /var/cache/apk/*

ADD requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

ADD transfer.py /transfer.py

CMD ["python3", "/transfer.py"]
