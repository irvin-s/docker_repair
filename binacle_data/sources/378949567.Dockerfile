FROM ubuntu:latest
MAINTAINER Wang YuZhi <wangxiaozhi0@gmail.com>

RUN apt-get update
RUN apt-get install -y python3 python3-pip python3-flask git
RUN git clone https://github.com/wangxiaozhi123/WebShell.git

EXPOSE 5000

CMD ["python3", "/WebShell/shell.py"]
