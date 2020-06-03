FROM ubuntu:14.04

COPY reader tag run.sh /
RUN apt-get update
RUN apt-get install -y nmap

EXPOSE 3456 6543

CMD /run.sh
