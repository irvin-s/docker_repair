FROM ubuntu:14.04

RUN apt-get install -y nmap

COPY FMS run.sh flag.txt /
EXPOSE 1234
CMD /run.sh
