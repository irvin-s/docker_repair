FROM ubuntu:16.04

ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install  apt-transport-https ca-certificates curl  software-properties-common -y
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install docker-ce -y
RUN apt-get install python3 -y
RUN apt-get install python3-pip -y
RUN pip3 install --upgrade pip
ADD requirements.txt /
RUN pip3 install -r requirements.txt

WORKDIR /app

ADD src /app

CMD ["python3", "event_checker.py"]