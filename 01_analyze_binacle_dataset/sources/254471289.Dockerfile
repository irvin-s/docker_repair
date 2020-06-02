FROM ubuntu:14.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python

WORKDIR /opt/brokenbox

COPY ./server.py ./

CMD ["python", "./server.py"]
