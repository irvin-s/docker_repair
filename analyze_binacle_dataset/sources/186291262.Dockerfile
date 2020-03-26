FROM ubuntu:14.04
MAINTAINER Matthias Kadenbach <matthias.kadenbach@gmail.com>

RUN apt-get update
RUN apt-get install -y python python-pip git
RUN pip install pyftpdlib

ADD ./ftp.py /ftp.py
RUN chmod +x /ftp.py

ENV FTP_ROOT /www
VOLUME ["/www"]

EXPOSE 21

CMD ["./ftp.py"]
