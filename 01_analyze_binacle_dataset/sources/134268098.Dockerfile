FROM ubuntu:14.04

run apt-get -y update
RUN apt-get install -y python-requests python-boto

ADD elastic-ip-attach /bin/elastic-ip-attach

CMD /bin/elastic-ip-attach
