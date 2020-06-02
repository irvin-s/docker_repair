FROM ubuntu:16.04
LABEL maintainer="nlkey2022@gmail.com"

RUN apt-get update -y && \
	apt-get install -y python3-pip python3 && \
	pip3 install flask Pillow && mkdir /home/uploads && mkdir /home/templates

ADD server.py /home/
ADD templates /home/templates
WORKDIR /home/uploads
ENTRYPOINT ["python3", "/home/server.py"]
