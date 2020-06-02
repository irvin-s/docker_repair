FROM debian:8

ADD run.sh /run.sh
ADD server /server

CMD /run.sh