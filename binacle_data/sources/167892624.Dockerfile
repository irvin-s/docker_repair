FROM shaddock/archlinux:latest
MAINTAINER Thibaut Lapierre <root@epheo.eu>

RUN pacman -Sy --noconfirm python-pip git

ENV SHDK_MODEL /shaddock/tests/model/shaddock.yml

ADD . /shaddock
RUN cd /shaddock && pip install .

CMD ["shdk"]
