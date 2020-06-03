FROM ubuntu:16.04
MAINTAINER wuwentao

RUN apt-get update && apt-get install -y python3 python3-pip
COPY . /opt
WORKDIR /opt
RUN pip3 install -r requirements.txt
ENTRYPOINT ["bash", "run.sh"]
